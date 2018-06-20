require 'json'
require 'net/https'
$templateString = File.read 'template.Dockerfile'
$templateString.gsub! "\"", "\\\""
$prefixName = 'xgheaven/alinode'
$versionsHost = 'npm.taobao.org'
$versionsUri = '/mirrors/alinode/index.json'
$versions = []

$majorVersionMap = {
    "1" => "1.10.0",
    "2" => "2.5.0",
    "3" => "3.11.3",
    "4" => "4.1.0",
    "latest" => "4.1.0"
}

def loadVersions()
    json = File.read './versions.json'
    versions = JSON.parse json
    $versions = versions.sort {|a, b|
        a['major'] > b['major'] ? a['major'] > b['major'] : a['minor'] > b['minor'] ? a['minor'] > b['minor'] : a['patch'] > b['patch']
        a['major'] 
    }
end

def getVersion(major, minor = -1, patch = -1)
    if ($versions.length === 0) 
        loadVersions
    end
end

def parseVersion(version)
    version = version[1, 5].split '.'
    major = version[0].to_i
    minor = version[1].to_i
    patch = version[2].to_i
    return {
        :major => major,
        :minor => minor,
        :patch => patch,
    }
end

def generateDockerfile(version, path)
    template = eval("\"#{$templateString}\"")
    File.write(".#{path}/Dockerfile", template)
end

def buildDockerfileFactiry(majorVersion)
    desc "Build Dockerfile for #{majorVersion}"
    task "build_dockerfile_#{majorVersion}" do
        version = $majorVersionMap[majorVersion]
        puts "Build for #{majorVersion}(#{version})"
        generateDockerfile version, "/#{majorVersion}"
    end
end

def buildFactory(version)
    desc "Build Docker Image for #{version}"
    task "build_#{version}" => ["build_dockerfile_#{version}"] do
        sh "docker build . -f ./#{version}/Dockerfile -t #{$prefixName}:#{version}"
    end
end

buildDockerfileFactiry('1')
buildDockerfileFactiry('2')
buildDockerfileFactiry('3')
buildDockerfileFactiry('4')
buildDockerfileFactiry('latest')

desc "Build Dockerfile"
task :build_dockerfile => [:build_dockerfile_latest, :build_dockerfile_4, :build_dockerfile_3, :build_dockerfile_2, :build_dockerfile_1]

buildFactory('1')
buildFactory('2')
buildFactory('3')
buildFactory('4')
buildFactory('latest')

desc "Build Docker Image for v1, v2, v3, v4, latest"
task :build_all => [:build_latest, :build_4, :build_3, :build_2, :build_1]

desc "Build Docker Image with special version"
task :build_version, [:version] do |t, args|
    version = args.version
    generateDockerfile version, ''
    sh "docker build . -t #{$prefixName}:#{version}"
end

desc "Load and Update alinode versions"
task :update_versions do
    resp = Net::HTTP.get $versionsHost, $versionsUri
    versions = JSON.parse(resp)['alinode_tab'].map do |version|
        parseVersion(version['version'])
    end
    File.write './versions.json', JSON.dump(versions)
end

desc "Build And Push"
task :build_push => [:build_all] do
    sh "docker push #{$prefixName}"
end

desc "Push image"
task :push do
    sh "docker push #{$prefixName}"
end

desc "test"
task :test, [:version] do |version|
    print getVersion(version)
end
