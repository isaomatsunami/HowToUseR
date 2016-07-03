# 世論調査データの生成ロジック

nSample <- 1000
d <- data.frame(
	ID = seq(nSample),
	SEX = rep(1:2, nSample/2),
	PREF = rep_len(1:3, length.out=nSample),
	AGE  = sample(1:6, nSample, replace=TRUE),
	Q1 = rep(0, nSample),
	Q2 = rep(0, nSample),
	Q3 = rep(0, nSample),
	Q4 = rep(0, nSample),
	Q5 = rep(0, nSample)
)
for (i in 1:nSample){
	# Q1:支持政党は選挙区によって違う
	if(d$PREF[i] == 1){
		# 自民が強い
		d$Q1[i] = sample(1:10, 1, replace=TRUE, prob=c(45, 25, 3, 3.5, 1, 1, 1, 1, 35, 10))
	}else if (d$PREF[i] == 2){
		# 自民と民進が均衡
		d$Q1[i] = sample(1:10, 1, replace=TRUE, prob=c(40, 40, 3, 3.5, 1, 1, 1, 1, 35, 10))
	}else{
		# 自民がやや強い
		d$Q1[i] = sample(1:10, 1, replace=TRUE, prob=c(40, 35, 3, 3.5, 1, 1, 1, 1, 35, 10))
	}

	# Q2:比例投票先は支持政党と一致するが、ややぶれる
	if(d$Q1[i] == 1){
		d$Q2[i] = sample(1:10, 1, replace=TRUE, prob=c(10, 2, 1, 1, 1, 1, 1, 1, 5, 2))
	}else if (d$Q1[i] == 2){
		d$Q2[i] = sample(1:10, 1, replace=TRUE, prob=c(2, 10, 1, 1, 1, 1, 1, 1, 5, 2))
	}else if (d$Q1[i] == 3){
		d$Q2[i] = sample(1:10, 1, replace=TRUE, prob=c(2, 1, 10, 1, 1, 1, 1, 1, 1, 1))
	}else if (d$Q1[i] == 4){
		d$Q2[i] = sample(1:10, 1, replace=TRUE, prob=c(1, 2, 1, 10, 1, 1, 1, 1, 1, 1))
	}else if (d$Q1[i] == 5){
		d$Q2[i] = sample(1:10, 1, replace=TRUE, prob=c(1, 1, 1, 1, 10, 1, 1, 1, 2, 2))
	}else if (d$Q1[i] == 6){
		d$Q2[i] = sample(1:10, 1, replace=TRUE, prob=c(1, 1, 1, 1, 1, 10, 1, 1, 2, 2))
	}else if (d$Q1[i] == 7){
		d$Q2[i] = sample(1:10, 1, replace=TRUE, prob=c(1, 1, 1, 1, 1, 1, 10, 1, 2, 2))
	}else if (d$Q1[i] == 8){
		d$Q2[i] = sample(1:10, 1, replace=TRUE, prob=c(1, 1, 1, 1, 1, 1, 1, 10, 2, 2))
	}else if (d$Q1[i] == 9){
		d$Q2[i] = sample(1:10, 1, replace=TRUE, prob=c(10, 10, 1, 2, 1, 1, 1, 1, 10, 5))
	}else{
		d$Q2[i] = sample(1:10, 1, replace=TRUE, prob=c(3, 2, 1, 1, 1, 1, 1, 1, 5, 10))
	}
	# Q3:景気回復
	# 政治データの不可思議。支持政党が景気評価を決める！
	if( (d$Q1[i] == 1) | (d$Q1[i] == 3) ){ # 自民と公明は同じ
		d$Q3[i] = sample(1:4, 1, replace=TRUE, prob=c(6, 3, 1.5, 0.5))
	}else if(d$Q1[i] == 2){
		d$Q3[i] = sample(1:4, 1, replace=TRUE, prob=c(2, 6, 1.5, 0.5))
	}else if(d$Q1[i] == 4){
		d$Q3[i] = sample(1:4, 1, replace=TRUE, prob=c(0.5, 6, 1.5, 0.5))
	}else{
		d$Q3[i] = sample(1:4, 1, replace=TRUE, prob=c(5, 5, 1.5, 0.5))
	}

	# Q4:安全保障関連法
	if( d$Q1[i] == 1 ){ # 自民と公明は異なる
		d$Q4[i] = sample(1:4, 1, replace=TRUE, prob=c(6, 2, 1.5, 0.5))
	}else if( d$Q1[i] == 3 ){ # 自民と公明は異なる
		d$Q4[i] = sample(1:4, 1, replace=TRUE, prob=c(2, 6, 1.5, 0.5))
	}else if(d$Q1[i] == 2){
		d$Q4[i] = sample(1:4, 1, replace=TRUE, prob=c(2, 6, 1.5, 0.5))
	}else if(d$Q1[i] == 4){
		d$Q4[i] = sample(1:4, 1, replace=TRUE, prob=c(0.5, 6, 1.5, 0.5))
	}else{
		d$Q4[i] = sample(1:4, 1, replace=TRUE, prob=c(5, 5, 1.5, 0.5))
	}

	# Q5:与党による改憲
	# 年齢層によって異なる
	d$Q5[i] = sample(1:4, 1, replace=TRUE, prob=c(2, d$AGE[1], 1.5, 0.5))
}

# 因子化
d$SEX = as.factor(d$SEX)
d$PREF = as.factor(d$PREF)
d$AGE = as.factor(d$AGE)
d$Q1 = as.factor(d$Q1)
d$Q2 = as.factor(d$Q2)
d$Q3 = as.factor(d$Q3)
d$Q4 = as.factor(d$Q4)
d$Q5 = as.factor(d$Q5)

# 保存
write.table(d, file="poll.csv", quote=FALSE, sep=",", row.names = FALSE, fileEncoding="utf-8")


