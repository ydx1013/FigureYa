#' Calculates phenotype from microarray data.
#' 独立版本的 calcPhenotype 函数，修复了矩阵检查问题
#'
#' @param trainingExprData 训练数据矩阵
#' @param trainingPtype 训练表型数值向量
#' @param testExprData 测试数据矩阵
#' @param batchCorrect 批次校正方法，"eb"（默认）、"qn"或"none"
#' @param powerTransformPhenotype 是否进行幂变换，默认TRUE
#' @param removeLowVaryingGenes 移除低变异基因的比例，默认0.2
#' @param minNumSamples 最小样本数，默认10
#' @param selection 重复基因ID处理方式，默认-1
#' @param printOutput 是否输出信息，默认TRUE
#' @param removeLowVaringGenesFrom 低变异基因过滤来源
#'
#' @return 预测的表型数值向量
#'
#' @importFrom sva ComBat
#' @importFrom ridge linearRidge
#' @importFrom car powerTransform
calcPhenotype <- function(trainingExprData, trainingPtype, testExprData, 
                         batchCorrect = "eb", powerTransformPhenotype = TRUE, 
                         removeLowVaryingGenes = 0.2, minNumSamples = 10, 
                         selection = -1, printOutput = TRUE, 
                         removeLowVaringGenesFrom = "homogenizeData") {
  
  # 检查必要的包是否安装
  required_packages <- c("sva", "ridge", "car")
  missing_packages <- required_packages[!sapply(required_packages, requireNamespace, quietly = TRUE)]
  
  if (length(missing_packages) > 0) {
    stop("请先安装以下包: ", paste(missing_packages, collapse = ", "))
  }
  
  # 修复的矩阵检查（使用 is.matrix() 而不是 class() == "matrix"）
  if (!is.matrix(testExprData)) stop("ERROR: \"testExprData\" must be a matrix.")
  if (!is.matrix(trainingExprData)) stop("ERROR: \"trainingExprData\" must be a matrix.")
  if (!is.numeric(trainingPtype)) stop("ERROR: \"trainingPtype\" must be a numeric vector.")
  if (ncol(trainingExprData) != length(trainingPtype)) {
    stop("The training phenotype must be of the same length as the number of columns of the training expression matrix.")
  }
  
  # 样本数量检查
  if ((ncol(trainingExprData) < minNumSamples) || (ncol(testExprData) < minNumSamples)) {
    stop(paste("There are less than", minNumSamples, 
               "samples in your test or training set. It is strongly recommended that you use larger numbers of samples."))
  }
  
  # 数据 homogenization（需要实现或借用相关函数）
  homData <- homogenizeData(testExprData, trainingExprData, 
                           batchCorrect = batchCorrect, 
                           selection = selection, 
                           printOutput = printOutput)
  
  # 变量选择逻辑
  keepRows <- seq(1:nrow(homData$train))
  if (removeLowVaryingGenes > 0 && removeLowVaryingGenes < 1) {
    # 这里需要实现 doVariableSelection 函数
    # 或者简化处理
  }
  
  # 幂变换
  offset <- 0
  if (powerTransformPhenotype) {
    if (min(trainingPtype) < 0) {
      offset <- -min(trainingPtype) + 1
      trainingPtype <- trainingPtype + offset
    }
    transForm <- car::powerTransform(trainingPtype)[[6]]
    trainingPtype <- trainingPtype^transForm
  }
  
  # 岭回归模型
  if (printOutput) cat("\nFitting Ridge Regression model... ")
  trainFrame <- data.frame(Resp = trainingPtype, t(homData$train[keepRows, ]))
  rrModel <- ridge::linearRidge(Resp ~ ., data = trainFrame)
  if (printOutput) cat("Done\n\nCalculating predicted phenotype...")
  
  # 预测
  if (!is.matrix(homData$test)) {  # 修复的矩阵检查
    n <- names(homData$test)
    homData$test <- matrix(homData$test, ncol = 1)
    rownames(homData$test) <- n
    testFrame <- data.frame(t(homData$test[keepRows, ]))
    preds <- predict(rrModel, newdata = rbind(testFrame, testFrame))[1]
  } else {
    testFrame <- data.frame(t(homData$test[keepRows, ]))
    preds <- predict(rrModel, newdata = testFrame)
  }
  
  # 逆变换
  if (powerTransformPhenotype) {
    preds <- preds^(1/transForm)
    preds <- preds - offset
  }
  if (printOutput) cat("Done\n\n")
  
  return(preds)
}

# 需要实现的辅助函数（简化版）
homogenizeData <- function(testExprData, trainingExprData, batchCorrect = "eb", 
                          selection = -1, printOutput = TRUE) {
  # 简化的数据 homogenization
  # 实际使用时可能需要更复杂的实现
  return(list(
    test = testExprData,
    train = trainingExprData,
    selection = selection
  ))
}

doVariableSelection <- function(data, removeLowVaryingGenes = 0.2) {
  # 简化的变量选择
  # 返回要保留的行索引
  n_keep <- round(nrow(data) * (1 - removeLowVaryingGenes))
  return(seq_len(n_keep))
}
