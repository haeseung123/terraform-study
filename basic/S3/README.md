# S3 실습

## aws cli 명령어
- cp: 로컬 <-> S3 업로드/다운로드

```
# 업로드
aws cli cp index.hmlt s3://{bucket name}

# 다운로드
aws cli cp s3://{bucket name} index.html
```

- mv: 이동
- rm: 삭제

## terraform apply / aws cli cp
<img width="1135" alt="스크린샷 2024-04-01 오후 4 32 02" src="https://github.com/haeseung123/terraform-study/assets/106800437/fbb6c575-0619-4bf1-aebd-5a3189d01403">