FROM ruby:2.5.3

#必要なパッケージのインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential \ 
                       libpq-dev \        
                       nodejs           
#作業ディレクトリの作成
RUN mkdir /myapp  #自身のアプリディレクトリ名を設定

#bundle install時、invalid byte sequence in US-ASCII (ArgumentError)が発生するため
# ENV RUBYOPT -EUTF-8

#作業ディレクトリをAPP_ROOTに割り当てる
# ENV APP_ROOT /sample_app  #自身のアプリディレクトリ名を設定 
WORKDIR /myapp

#ローカルのGemfileを追加
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

#Gemfileのbundle installを実行
RUN bundle install
COPY . /myapp
