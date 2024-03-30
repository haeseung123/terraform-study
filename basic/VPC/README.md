# VPC 실습

## 1. VPC
- IP 대역 : 10.0.0.0/16

<br>

## 2. Subnet
- Region: ap-northeast-2

<table>
    <tr>
        <td>Tags</td>
        <td>AZ</td>
        <td>Subnet</td>
        <td>IPv4 CIDR</td>
    </tr>
    <tr>
        <td>subnet-test-1</td>
        <td>ap-northeast-2a</td>
        <td>first_subnet</td>
        <td>10.0.1.0/24</td>
    </tr>
    <tr>
        <td>subnet-test-2</td>
        <td>ap-northeast-2b</td>
        <td>second_subnet</td>
        <td>10.0.2.0/24</td>
    </tr>
    <tr>
        <td>private-subnet-test-1</td>
        <td>ap-northeast-2a</td>
        <td>first_private_subnet</td>
        <td>10.0.3.0/24</td>
    </tr>
    <tr>
        <td>private-subnet-test-2</td>
        <td>ap-northeast-2b</td>
        <td>second_private_subnet</td>
        <td>10.0.4.0/24</td>
    </tr>
</table>

<br>

## 예상 아키텍처
<img width="1157" alt="image" src="https://github.com/haeseung123/terraform-study/assets/106800437/f51e3807-7a74-4f71-91da-7a653b86690c">
