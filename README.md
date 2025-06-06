# Trend Analysis of Product Categories using Hadoop MapReduce

## Group
- EG/2020/3964 - Hettiarachchi UADD
- EG/2020/4061 - Madhuwantha BKTR
- EG/2020/4146 - Ranaweera RAPI


## Project Objective
This project analyzes trends of Amazon product reviews over time using Hadoop MapReduce. It extracts yearly average sentiment scores to visualize changes in customer opinion for each product category.

## Dataset
- Source: https://www.kaggle.com/datasets/saurav9786/amazon-product-reviews
- Columns Used: `ProductId`, `Time`, `Score`
- Preprocessing: UNIX `cut`, `awk`, `grep` used to clean and extract relevant columns.

## Tools & Technologies
- Hadoop (installed on Ubuntu via VirtualBox)
- MapReduce (Shell scripts: `mapper.sh`, `reducer.sh`)
- HDFS for storage and job execution

## MapReduce Job Description

### Mapper (`mapper.sh`)
- Input: Raw lines from the dataset
- Process:
  - Extracts `ProductId`, timestamp, and `Score`
  - Converts timestamp to Year
  - Emits `ProductID_Year` as key and `Score` as value

### Reducer (`reducer.sh`)
- Input: Sorted grouped output of mapper
- Process:
  - Aggregates sentiment score and count per `ProductID_Year`
  - Outputs average sentiment per year for each product

### Example Output:


## Result Interpretation
This system differs from traditional aggregation in that it incorporates **time-based trends**. Instead of one average score per product, it reveals **yearly sentiment fluctuations**, helping identify:
- Customer satisfaction over time
- Product rating trends
- Temporal anomalies or improvements

## Execution Evidence
Screenshots of:
- Hadoop daemons running (`jps`)
- HDFS setup
- Job execution completion
- Sample output

(See `/screenshots` folder)

### Prerequisites
- Hadoop installed and running
- Input file (`Reviews.csv`) placed in HDFS

### Commands:

```bash
hdfs dfs -mkdir /input
hdfs dfs -put Reviews.csv /input

hadoop jar /usr/lib/hadoop/hadoop-streaming.jar \
  -input /input/Reviews.csv \
  -output /output/review_trends \
  -mapper mapper.sh \
  -reducer reducer.sh

hdfs dfs -cat /output/review_trends/part-00000

