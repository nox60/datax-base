env.BUILD_VERSION      = null
env.CURRENT_STAGE      = null
env.FAILED_REASON      = null
env.CURRENT_BRANCH     = null


node {
    //Pull Repo
    stage ('Check out'){
        print "Current branch is ${env.CURRENT_BRANCH}"

        try{
            git  url: "https://gitee.com/nox/DataX.git", branch: "master"
        }catch(e){
            env.CURRENT_STAGE = '拉取GIT代码'
            env.FAILED_REASON = e
            // failedNotification()
            throw e
        }
    }

    //Build Code
    //构建程序
    stage ('Build'){
        try{
            docker.image('registry.cn-shenzhen.aliyuncs.com/nox60/maven-public:3.5.3').inside('-v /opt/local/maven/m2:/root/.m2 --entrypoint "" ') {
                sh 'mvn -U clean package assembly:assembly -Dmaven.test.skip=true -pl !oceanbasev10reader,!oceanbasev10writer,!oscarwriter,!oscarreader '
            }
        } catch(e){
            env.CURRENT_STAGE = '编译代码'
            env.FAILED_REASON = e
            throw e
        }
    }


    stage ('Build docker image and push to registry'){
        def dockerImageCore = null
        try{
            sh 'cp /usr/share/zoneinfo/Asia/Shanghai .'
            dockerImageCore = docker.build("registry.cn-hangzhou.aliyuncs.com/nox60/datax-base")
            docker.withRegistry("https://registry.cn-chengdu.aliyuncs.com","aliyun-nox60-cd") {
                            dockerImageCore.push('0.0.1')
            }
        }catch(e){
            env.CURRENT_STAGE = '打包镜像 & 推送到仓库'
            env.FAILED_REASON = e
            throw e
        }
    }


}
