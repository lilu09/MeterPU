cmake_minimum_required(VERSION 3.0)

if(PROJECT_NAME)
	set(MeterPU_SUBPROJECT ON)
endif()

project(MeterPU LANGUAGES CXX VERSION 0.8)

set(CMAKE_INSTALL_PREFIX "/usr" CACHE PATH
	"Install path prefix, prepended onto install directories."
	FORCE)

include(CMakePackageConfigHelpers)

add_library(MeterPU INTERFACE)

target_include_directories(MeterPU INTERFACE
	$<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}>
	$<INSTALL_INTERFACE:include>)

# Alias to "link" against if subproject.
add_library(MeterPU::MeterPU ALIAS MeterPU)

# Install only if not subproject.
if(NOT MeterPU_SUBPROJECT)
	install(FILES ${CMAKE_CURRENT_LIST_DIR}/meterpu.h
		DESTINATION include/)
	
	install(TARGETS MeterPU
		EXPORT MeterPUTargets
		DESTINATION lib)
	install(EXPORT MeterPUTargets
		NAMESPACE MeterPU::
		DESTINATION lib/cmake/MeterPU)

	configure_package_config_file(
		${CMAKE_CURRENT_LIST_DIR}/CMake/MeterPUConfig.cmake.in
		${CMAKE_CURRENT_BINARY_DIR}/MeterPUConfig.cmake
		INSTALL_DESTINATION lib/cmake/MeterPU
	)

	write_basic_package_version_file(
			${CMAKE_CURRENT_BINARY_DIR}/MeterPUConfigVersion.cmake
			COMPATIBILITY SameMajorVersion)

	install(FILES
			${CMAKE_CURRENT_BINARY_DIR}/MeterPUConfig.cmake
			${CMAKE_CURRENT_BINARY_DIR}/MeterPUConfigVersion.cmake
		DESTINATION
			lib/cmake/MeterPU)
endif()
