# -------------------------------------------------------------------
# 파일명 : sqldf.R
# 설  명 : sql 연습용
# 작성자 : 이재병 (010-2775-0930, jblee@begas.co.kr)
# 작성일 : 2020/03/19
# 패키지 : sqldf
# 참  고 : https://github.com/ggrothendieck/sqldf
# -------------------------------------------------------------------
install.packages("sqldf")
library(sqldf)


head(USArrests)

# 모든 열 선택
sqldf('SELECT * FROM USArrests')

# 행의 개수
sqldf('SELECT count(*) FROM USArrests')

# 특정 열 선택
sqldf('SELECT Murder, Assault FROM USArrests')

# 특정열의 Unique한 값
sqldf('SELECT DISTINCT Murder FROM USArrests')

# 특정 열 합계, 평균
sqldf('SELECT avg(Assault), sum(Murder) FROM USArrests')


# 특정 조건을 만족하는 행 추출
sqldf('SELECT * FROM USArrests WHERE Murder > 15')

# 특정 조건을 만족하는 행 오름차순추출 
sqldf('SELECT * FROM USArrests WHERE Murder > 15 ORDER BY URbanPop')

# 특정 조건을 만족하는 행 내림차순 추출
sqldf('SELECT * FROM USArrests WHERE Murder > 15 ORDER BY URbanPop DESC')
sqldf('SELECT * FROM iris WHERE Species LIKE "%s%"') # s를 포함하는 데이터
sqldf('SELECT * FROM iris WHERE Species LIKE "s%"') # s로 시작하는 데이터
sqldf('SELECT * FROM iris WHERE Species LIKE "%r"') # r로 끝나는 데이터
# 특정 조건을 만족하는 행 limit 사용하여 추출
sqldf('SELECT * FROM iris ORDER BY "Sepal.Length" DESC LIMIT 3')

# 그룹 평균 구하기
sqldf('SELECT Species, avg("Sepal.Length") FROM iris GROUP BY Species')

# 조인
Abbr <- data.frame(Species = levels(iris$Species), Abbr = c("S","Ve","Vi"))
sqldf('SELECT "Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", iris.Species, "Abbr"
      FROM iris 
      LEFT JOIN Abbr ON iris.Species = Abbr.Species')

sqldf('SELECT Abbr, avg("Sepal.length")
      FROM iris
      LEFT JOIN Abbr on iris.Species=Abbr.Species GROUP BY iris.Species')

sqldf('SELECT Abbr, avg("Sepal.length") 
      FROM iris, Abbr
      WHERE iris.Species = Abbr.Species GROUP BY iris.Species')

SNP1x <- data.frame(Animal = c(194073197,194073197,194073197,194073197,194073197),
                    Marker = c("P1001","P1002","P1004","P1005","P1006"),
                    x = c(2,1,2,0,2),
                    row.names = c("3213","1295","915","2833","1487"))
SNP4 <- data.frame(Animal = c(194073197,194073197,194073197,194073197,194073197,194073197),
                    Marker = c("P1001","P1002","P1004","P1005","P1006","P1007"),
                    y = rep(0.021088,6),
                    row.names = c("3213","1295","915","2833","1487","1885"))

sqldf('SELECT SNP4.Animal, SNP4.Marker, y, x 
      FROM SNP4
      LEFT JOIN SNP1x ON (SNP4.Marker, SNP4.Animal) = (SNP1x.Marker, SNP1x.Animal)')

# 행 합치기
sqldf('SELECT Animal, Marker, x
      FROM SNP1x
      UNION
      SELECT Animal, Marker, y
      FROM SNP4')
