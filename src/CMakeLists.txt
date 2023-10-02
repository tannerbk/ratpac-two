add_library( EOS SHARED
  Eos.cc
  GeoEosFactory.cc
  DichroiconArrayFactory.cc
  HitmanProc.cc
  NtupleProc.cc
)

target_include_directories( EOS PUBLIC
  $<BUILD_INTERFACE:${EOS_INCLUDE_DIR}>
  $<INSTALL_INTERFACE:include>)

file(COPY include/ DESTINATION ${EOS_INCLUDE_DIR})

add_executable(eos eos.cpp)
target_link_libraries(eos PUBLIC 
  EOS ${ROOT_LIBRARIES} ${Geant4_LIBRARIES} ${Ratpac_LIBRARIES} ${NLOPT_LIBRARIES})

set_target_properties(EOS eos
  PROPERTIES
  ARCHIVE_OUTPUT_DIRECTORY ${EOS_LIBRARY_DIR}
  LIBRARY_OUTPUT_DIRECTORY ${EOS_LIBRARY_DIR})

install(TARGETS EOS eos 
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  RUNTIME DESTINATION bin)

install(DIRECTORY ${EOS_INCLUDE_DIR}
  DESTINATION ${CMAKE_INSTALL_PREFIX})
