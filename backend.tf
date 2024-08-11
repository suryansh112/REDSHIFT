terraform{
backend "s3"{
    bucket = "suryanshredshiftbucket"
    key = "backend.tf"
    region = "us-east-1"
    

}
}