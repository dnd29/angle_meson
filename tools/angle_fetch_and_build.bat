REM REM https://github.com/google/angle/blob/main/doc/DevSetup.md

REM REM On Windows:
REM REM IMPORTANT: Set DEPOT_TOOLS_WIN_TOOLCHAIN=0 in your environment if you are not a Googler.
REM REM Install Visual Studio Community 2022
REM REM Install the Windows 10 SDK, latest version.
	REM REM You can install it through Visual Studio Installer if available.
	REM REM The SDK is required for GN-generated Visual Studio projects, the D3D Debug runtime, and the latest HLSL Compiler runtime.

set DEPOT_TOOLS_WIN_TOOLCHAIN=0
if exist depot_tools\ (
	cd depot_tools
	set "path=%cd%\depot_tools;%path%"
	cd angle
	REM cmd /S /C gclient sync --force --with_branch_heads --with_tags
) else (
	mkdir depot_tools
	set "path=%cd%\depot_tools;%path%"
	
	curl http://storage.googleapis.com/chrome-infra/depot_tools.zip -o ./depot_tools/depot_tools.zip
	cd depot_tools
	..\7-Zip_Kor_Portable\App\7-Zip\7z x ./depot_tools.zip
	
	mkdir angle
	cd angle
	cmd /S /C fetch angle
)

cmd /S /C gn gen out/Debug_UWP_x86 "--sln=angle-debug --ide=vs2022 --args=is_debug=true target_cpu=\"x86\" target_os=\"winuwp\" is_component_build=false is_clang=false angle_enable_d3d9=false angle_enable_d3d11=true angle_enable_gl=false angle_enable_vulkan=true angle_enable_glsl=true angle_enable_trace=true angle_enable_trace_events=false" 
cmd /S /C gn gen out/Debug_UWP_x64 "--sln=angle-debug --ide=vs2022 --args=is_debug=true target_cpu=\"x64\" target_os=\"winuwp\" is_component_build=false is_clang=false angle_enable_d3d9=false angle_enable_d3d11=true angle_enable_gl=false angle_enable_vulkan=true angle_enable_glsl=true angle_enable_trace=true angle_enable_trace_events=false" 

cmd /S /C gn gen out/Debug_UWP_ARM "--sln=angle-debug --ide=vs2022 --args=is_debug=true target_cpu=\"arm\" target_os=\"winuwp\" is_component_build=false is_clang=false angle_enable_d3d9=false angle_enable_d3d11=true angle_enable_gl=false angle_enable_vulkan=true angle_enable_glsl=true angle_enable_trace=true angle_enable_trace_events=false" 
cmd /S /C gn gen out/Debug_UWP_ARM64 "--sln=angle-debug --ide=vs2022 --args=is_debug=true target_cpu=\"arm64\" target_os=\"winuwp\" is_component_build=false is_clang=false angle_enable_d3d9=false angle_enable_d3d11=true angle_enable_gl=false angle_enable_vulkan=true angle_enable_glsl=true angle_enable_trace=true angle_enable_trace_events=false" 

cmd /S /C gn gen out/Release_UWP_x86 "--sln=angle-release --ide=vs2022 --args=is_debug=false target_cpu=\"x86\" target_os=\"winuwp\" is_component_build=false is_clang=false angle_enable_d3d9=false angle_enable_d3d11=true angle_enable_gl=false angle_enable_vulkan=true angle_enable_glsl=true" 
cmd /S /C gn gen out/Release_UWP_x64 "--sln=angle-release --ide=vs2022 --args=is_debug=false target_cpu=\"x64\" target_os=\"winuwp\" is_component_build=false is_clang=false angle_enable_d3d9=false angle_enable_d3d11=true angle_enable_gl=false angle_enable_vulkan=true angle_enable_glsl=true" 

cmd /S /C gn gen out/Release_UWP_ARM "--sln=angle-release --ide=vs2022 --args=is_debug=false target_cpu=\"arm\" target_os=\"winuwp\" is_component_build=false is_clang=false angle_enable_d3d9=false angle_enable_d3d11=true angle_enable_gl=false angle_enable_vulkan=true angle_enable_glsl=true" 
cmd /S /C gn gen out/Release_UWP_ARM64 "--sln=angle-is_component_build --ide=vs2022 --args=is_debug=false target_cpu=\"arm64\" target_os=\"winuwp\" is_component_build=false is_clang=false angle_enable_d3d9=false angle_enable_d3d11=true angle_enable_gl=false angle_enable_vulkan=true angle_enable_glsl=true" 

cmd /S /C gn gen out/Debug_x86 "--sln=angle-debug --ide=vs2022 --args=is_debug=true target_cpu=\"x86\" is_component_build=false is_clang=false angle_enable_d3d9=false angle_enable_d3d11=true angle_enable_gl=false angle_enable_vulkan=true angle_enable_glsl=true angle_enable_trace=true angle_enable_trace_events=false" 
cmd /S /C gn gen out/Debug_x64 "--sln=angle-debug --ide=vs2022 --args=is_debug=true target_cpu=\"x64\" is_component_build=false is_clang=false angle_enable_d3d9=false angle_enable_d3d11=true angle_enable_gl=false angle_enable_vulkan=true angle_enable_glsl=true angle_enable_trace=true angle_enable_trace_events=false" 

cmd /S /C gn gen out/Release_x86 "--sln=angle-release --ide=vs2022 --args=is_debug=false target_cpu=\"x86\" is_component_build=false is_clang=false angle_enable_d3d9=false angle_enable_d3d11=true angle_enable_gl=false angle_enable_vulkan=true angle_enable_glsl=true angle_enable_trace=false angle_enable_trace_events=false"
cmd /S /C gn gen out/Release_x64 "--sln=angle-release --ide=vs2022 --args=is_debug=false target_cpu=\"x64\" is_component_build=false is_clang=false angle_enable_d3d9=false angle_enable_d3d11=true angle_enable_gl=false angle_enable_vulkan=true angle_enable_glsl=true angle_enable_trace=false angle_enable_trace_events=false" 

cmd /S /C autoninja -C out/Debug_UWP_x86 && call :copy_files Debug_UWP_x86 UWP_Lib Debug_x86
cmd /S /C autoninja -v -C out/Debug_UWP_x64 && call :copy_files Debug_UWP_x64 UWP_Lib Debug_x64

cmd /S /C autoninja -C out/Debug_UWP_ARM && call :copy_files Debug_UWP_ARM UWP_Lib Debug_ARM
cmd /S /C autoninja -v -C out/Debug_UWP_ARM64 && call :copy_files Debug_UWP_ARM64 UWP_Lib Debug_ARM64

cmd /S /C autoninja -v -C out/Release_UWP_x86 && call :copy_files Release_UWP_x86 UWP_Lib Release_x86
cmd /S /C autoninja -v -C out/Release_UWP_x64 && call :copy_files Release_UWP_x64 UWP_Lib Release_x64

cmd /S /C autoninja -v -C out/Release_UWP_ARM && call :copy_files Release_UWP_ARM UWP_Lib Release_ARM
cmd /S /C autoninja -v -C out/Release_UWP_ARM64 && call :copy_files Release_UWP_ARM64 UWP_Lib Release_ARM64

cmd /S /C autoninja -C out/Debug_x86 && call :copy_files Debug_x86 Win32_Lib Debug_x86
cmd /S /C autoninja -C out/Debug_x64 && call :copy_files Debug_x64 Win32_Lib Debug_x64

cmd /S /C autoninja -C out/Release_x86 && call :copy_files Release_x86 Win32_Lib Release_x86
cmd /S /C autoninja -C out/Release_x64 && call :copy_files Release_x64 Win32_Lib Release_x64

goto :EOF

:copy_files
copy /Y ".\out\%1\d3dcompiler_47.dll" "..\..\..\lib\%2\%3\d3dcompiler_47.dll"
copy /Y ".\out\%1\libEGL.dll" "..\..\..\lib\%2\%3\libEGL.dll"
copy /Y ".\out\%1\libGLESv2.dll" "..\..\..\lib\%2\%3\libGLESv2.dll"
copy /Y ".\out\%1\angle_util.dll.lib" "..\..\..\lib\%2\%3\lib\angle_util.dll.lib"
copy /Y ".\out\%1\libEGL.dll.lib" "..\..\..\lib\%2\%3\lib\libEGL.dll.lib"
copy /Y ".\out\%1\libGLESv2.dll.lib" "..\..\..\lib\%2\%3\lib\libGLESv2.dll.lib"