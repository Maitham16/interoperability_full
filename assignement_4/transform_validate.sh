#!/bin/sh

# Transformation and Validation for transform1.xslt
./iopdst.sh xslt30-xml output1.xml transform1.xslt output_t1.xml
./iopdst.sh pretty-xml output_t1.xml
./iopdst.sh relaxng schema2.rng output_t1.xml

# Transformation and Validation for transform2.xslt
./iopdst.sh xslt30-xml output2.xml transform2.xslt output_t2.json
./iopdst.sh pretty-json output_t2.json
./iopdst.sh jsonschema schema2.json output_t2.json

# Transformation and Validation for transform1.xq
./iopdst.sh xquery31-xml output1.xml transform1.xq output_t3.json
./iopdst.sh pretty-json output_t3.json
./iopdst.sh jsonschema schema2.json output_t3.json

# Transformation and Validation for transform2.xq
./iopdst.sh xquery31-xml output1.xml transform2.xq output_t4.xml
./iopdst.sh pretty-xml output_t4.xml
./iopdst.sh relaxng schema1.rng output_t4.xml