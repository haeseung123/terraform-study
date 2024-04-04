# RDS 실습

[Amazon RDS on AWS](https://aws.amazon.com/ko/solutions/implementations/amazon-rds-postgresql/)

AWS의 아키텍처 모범사례를 테라폼으로 구현해보기

<br>

## 예상 아키텍처
<img width="1157" alt="image" src="https://github.com/haeseung123/terraform-study/assets/106800437/7b6497d9-e761-41c5-a829-58b925822a94">


### Public subnet
- 프라이빗 서브넷 리소스의 아웃바운드 인터넷 통신을 위한 NAT gateway
- bastion host가 존재하는 오토스케일링 그룹 생성
    - 내부 시스템 엑세스 제어를 위한 선택적 bastion host
    - launch_template 생성 시 **associate_public_ip_address = true** 설정으로 public IP 부여 -> 퍼블릭 인스턴스에 대한 인바운드 접근 허용

### Private subnet
- 각각의 가용 영역에 쓰기/읽기 역할을 담당하는 인스턴스가 포함된 RDS cluster 생성


<br>

### Auto scaling 인스턴스 생성 결과
<img width="1150" alt="스크린샷 2024-04-04 오전 1 05 02" src="https://github.com/haeseung123/terraform-study/assets/106800437/11ae8e76-18c7-40a9-b51c-5752c46bf90f">


### RDS cluster 생성 결과
<img width="884" alt="스크린샷 2024-04-04 오전 1 10 02" src="https://github.com/haeseung123/terraform-study/assets/106800437/f754afd8-32a0-473f-a058-82792fb38159">


### bastion host를 통한 mysql 접속 확인
<img width="1013" alt="image" src="https://github.com/haeseung123/terraform-study/assets/106800437/dd3064ec-1c7a-42c6-91bc-6d47337517bf">

<img width="985" alt="image" src="https://github.com/haeseung123/terraform-study/assets/106800437/47674f89-658f-49dc-9539-f5999bf46835">