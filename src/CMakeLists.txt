add_library( eosobj OBJECT
  GeoEosFactory.cc
)

target_include_directories( eosobj PUBLIC
  $<BUILD_INTERFACE:${EOS_INCLUDE_DIR}>
  $<INSTALL_INTERFACE:include>)

file(COPY include/ DESTINATION ${EOS_INCLUDE_DIR})

add_executable(eos eos.cpp)
target_link_libraries(eos PUBLIC 
  eosobj ${ROOT_LIBRARIES} ${Geant4_LIBRARIES} ${Ratpac_LIBRARIES})
#set_target_properties(eos
#  PROPERTIES
#  RUNTIME_OUTPUT_DIRECTORY ${EOS_BINARY_DIR}
#  ARCHIVE_OUTPUT_DIRECTORY ${EOS_LIBRARY_DIR}
#  LIBRARY_OUTPUT_DIRECTORY ${EOS_LIBRARY_DIR})

install(TARGETS eos RUNTIME DESTINATION bin)
