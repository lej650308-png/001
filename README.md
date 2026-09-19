# 001

## VS Code 설치

Debian/Ubuntu 에서 Microsoft 공식 apt 저장소를 통해 Visual Studio Code 를 설치합니다.

```bash
sudo ./scripts/install-vscode.sh
```

스크립트가 하는 일:

1. `ca-certificates`, `curl`, `gpg`, `apt-transport-https` 설치
2. Microsoft 서명 키를 `/usr/share/keyrings/microsoft.gpg` 에 등록
3. `https://packages.microsoft.com/repos/code stable main` 저장소를 `/etc/apt/sources.list.d/vscode.list` 에 추가
4. `apt-get install -y code`

### 헤드리스 서버에서

GUI 는 X/Wayland 디스플레이가 필요하므로, 디스플레이가 없는 서버에서는 CLI 를 사용합니다.

| 명령 | 용도 |
| --- | --- |
| `code tunnel` | vscode.dev 또는 로컬 VS Code 에서 이 머신에 원격 접속 |
| `code serve-web` | 브라우저용 VS Code 를 로컬 포트에 띄움 |
| `code --version` | 버전 확인 |

root 로 실행할 때는 `--no-sandbox --user-data-dir=<경로>` 가 필요합니다.

```bash
code --version --no-sandbox --user-data-dir=/tmp/vscode
```

### 다른 OS

- **macOS / Windows**: https://code.visualstudio.com/download 에서 설치 파일을 받습니다.
- **Fedora / RHEL**: `dnf` 용 저장소 설정은 https://code.visualstudio.com/docs/setup/linux 참고.
