PYTHON ?= python3

makefile_dir := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

all: bblfsh/github/com/gogo/protobuf/gogoproto/gogo_pb2.py \
     bblfsh/github/com/bblfsh/sdk/uast/generated_pb2.py \
     bblfsh/github/com/bblfsh/sdk/protocol/generated_pb2_*.py \
     bblfsh/github/__init__.py \
     bblfsh/github/com/__init__.py \
     bblfsh/github/com/gogo/__init__.py \
     bblfsh/github/com/gogo/protobuf/__init__.py \
     bblfsh/github/com/gogo/protobuf/gogoproto/__init__.py \
     bblfsh/github/com/bblfsh/__init__.py \
     bblfsh/github/com/bblfsh/sdk/__init__.py \
     bblfsh/github/com/bblfsh/sdk/uast/__init__.py \
     bblfsh/github/com/bblfsh/sdk/protocol/__init__.py

bblfsh/github/com/gogo/protobuf/gogoproto/gogo_pb2.py: github.com/gogo/protobuf/gogoproto/gogo.proto
	protoc --python_out bblfsh github.com/gogo/protobuf/gogoproto/gogo.proto

bblfsh/github/com/bblfsh/sdk/uast/generated_pb2.py: github.com/bblfsh/sdk/uast/generated.proto
	protoc --python_out bblfsh github.com/bblfsh/sdk/uast/generated.proto

bblfsh/github/com/bblfsh/sdk/protocol:
	@mkdir -p $@

bblfsh/github/com/bblfsh/sdk/protocol/generated_pb2_*.py: \
        bblfsh/github/com/bblfsh/sdk/protocol github.com/bblfsh/sdk/protocol/generated.proto
	$(PYTHON) -m grpc.tools.protoc --python_out=bblfsh/github/com/bblfsh/sdk/protocol \
	    --grpc_python_out=bblfsh/github/com/bblfsh/sdk/protocol \
	    -I github.com/bblfsh/sdk/protocol -I $(makefile_dir) \
	    github.com/bblfsh/sdk/protocol/generated.proto

%/__init__.py:
	@touch $@
