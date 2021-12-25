#!/bin/sh
# 블로그 저장 폴더로 이동한다.
# 인코딩 에러 발생시 다음의 코드를 실행한다.
chcp 65001
# 지킬을 실행한다.
jekyll build
bundle exec jekyll serve