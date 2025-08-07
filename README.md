# n8n Local Development Environment

이 프로젝트는 n8n을 로컬에서 개발하고 Docker를 통해 배포할 수 있는 환경을 제공합니다.

## 🚀 빠른 시작

### 1. 환경 설정
```bash
# 환경변수 파일 복사
cp .env.example .env

# 필요에 따라 .env 파일 수정
vim .env
```

### 2. 로컬 개발 환경 실행
```bash
# Docker Compose로 전체 서비스 실행
docker-compose up -d

# 로그 확인
docker-compose logs -f n8n
```

### 3. n8n 접속
- URL: http://localhost:5678
- 기본 계정: admin / admin123 (`.env`에서 변경 가능)

## 📁 프로젝트 구조

```
n8n_local/
├── docker-compose.yml    # 로컬 개발용 Docker Compose
├── Dockerfile           # 프로덕션 배포용 Docker 이미지
├── .env                # 환경변수 설정
├── .env.example        # 환경변수 템플릿
├── .gitignore         # Git 무시 파일
└── README.md          # 이 파일
```

## 🐳 Docker 명령어

### 개발 환경
```bash
# 서비스 시작
docker-compose up -d

# 서비스 중지
docker-compose down

# 볼륨까지 완전 삭제
docker-compose down -v

# 특정 서비스 재시작
docker-compose restart n8n
```

### 프로덕션 배포
```bash
# Docker 이미지 빌드
docker build -t my-n8n:latest .

# 이미지 실행
docker run -d \
  --name n8n-prod \
  -p 5678:5678 \
  -e DB_TYPE=postgresdb \
  -e DB_POSTGRESDB_HOST=your-db-host \
  -e DB_POSTGRESDB_DATABASE=n8n \
  -e DB_POSTGRESDB_USER=n8n \
  -e DB_POSTGRESDB_PASSWORD=secure-password \
  my-n8n:latest
```

## ⚙️ 환경변수 설정

주요 환경변수들:

| 변수명 | 기본값 | 설명 |
|--------|--------|------|
| `N8N_BASIC_AUTH_USER` | admin | 기본 인증 사용자명 |
| `N8N_BASIC_AUTH_PASSWORD` | admin123 | 기본 인증 비밀번호 |
| `POSTGRES_DB` | n8n | PostgreSQL 데이터베이스명 |
| `POSTGRES_USER` | n8n | PostgreSQL 사용자명 |
| `POSTGRES_PASSWORD` | n8n_password | PostgreSQL 비밀번호 |
| `WEBHOOK_URL` | http://localhost:5678/ | 웹훅 URL |
| `GENERIC_TIMEZONE` | Asia/Seoul | 시간대 |

## 🤖 외부 스크립트 자동화

### 스크립트 설정 방법

1. 로컬에 `scripts/` 폴더 생성
2. 실행할 스크립트들을 `scripts/` 폴더에 저장
3. 외부 파일 접근이 필요하면 docker-compose.yml에 볼륨 마운트 추가:
   ```yaml
   volumes:
     - /path/to/your/files:/workspace
   ```

### n8n 워크플로우에서 스크립트 실행하기

1. **Execute Command** 노드 사용:
   ```bash
   /root/scripts/your_script.sh
   ```

### 마운트된 경로
- `/root/scripts` → `./scripts` (로컬 스크립트들)
- 필요시 추가: 외부 작업 디렉토리

### 설치된 의존성
- Python 3 + pip + venv
- Bash shell
- Chromium + ChromeDriver (Selenium용)
- 기본 빌드 도구들

## 🔧 커스터마이징

### 1. 추가 패키지 설치
`Dockerfile`을 수정하여 필요한 패키지를 추가할 수 있습니다.

### 2. 볼륨 마운트
로컬 파일을 컨테이너와 공유하려면 `docker-compose.yml`의 volumes 섹션을 수정하세요.

### 3. 포트 변경
다른 포트를 사용하려면 `docker-compose.yml`의 ports 섹션과 환경변수를 수정하세요.

## 🐛 문제해결

### 포트 충돌
```bash
# 포트 사용 확인
lsof -i :5678

# 서비스 재시작
docker-compose restart
```

### 데이터베이스 연결 오류
```bash
# PostgreSQL 상태 확인
docker-compose logs postgres

# 데이터베이스 초기화
docker-compose down -v
docker-compose up -d
```

### 로그 확인
```bash
# 전체 로그
docker-compose logs

# 특정 서비스 로그
docker-compose logs n8n
docker-compose logs postgres
```

## 📚 추가 정보

- [n8n 공식 문서](https://docs.n8n.io/)
- [n8n Docker Hub](https://hub.docker.com/r/n8nio/n8n)
- [n8n GitHub](https://github.com/n8n-io/n8n)