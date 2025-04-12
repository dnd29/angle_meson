project('angle', 'c', version: '1c0bcb06e36fe6920fb09512bcfe7519fe1bcbb2')

# 옵션 가져오기
target_platform = get_option('platform')
message('Target platform: ' + target_platform)
target_arch = get_option('arch')
if target_arch == 'any'
	target_arch = 'x64'
else target_arch == 'arm64-v8a'
	target_arch = 'ARM64'
endif
buildtype = get_option('buildtype')

target_dir_name = ''
if target_platform == 'windows'
	target_dir_name = 'Win32'
else
	target_dir_name = 'UWP'
endif

build_type_directory_string = 'Release'
if buildtype == 'debug'
    build_type_directory_string = 'Debug'
endif

lib_path = './lib/@0@_Lib/@1@_@2@/'.format(target_dir_name, build_type_directory_string, target_arch)

dlls = [lib_path + 'libEGL.dll', lib_path + 'libGLESv2.dll', lib_path + 'd3dcompiler_47.dll']


angle_dep = declare_dependency(
    include_directories: include_directories('./include'),
    link_args: [ \
		'-L' + meson.current_source_dir() + '/' + lib_path + '/lib/',  \
		'-llibEGL.dll', \
		'-llibGLESv2.dll' \
	]
    #sources: [lib_path + 'lib/libEGL.dll.lib', lib_path + 'lib/libGLESv2.dll.lib' ]
)
install_data(dlls, install_dir: get_option('bindir'))