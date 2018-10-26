#!/usr/bin/env bash

### Test Detectors


slither tests/uninitialized.sol --disable-solc-warnings --detectors uninitialized-state
if [ $? -ne 1 ]; then
    exit 1
fi

# contains also the test for the suicidal detector
slither tests/backdoor.sol --disable-solc-warnings --detectors backdoor
if [ $? -ne 1 ]; then
    exit 1
fi

slither tests/pragma.0.4.24.sol --disable-solc-warnings --detectors pragma
if [ $? -ne 1 ]; then
    exit 1
fi

slither tests/old_solc.sol.json --solc-ast --detectors solc-version
if [ $? -ne 1 ]; then
    exit 1
fi

slither tests/reentrancy.sol --disable-solc-warnings --detectors reentrancy
if [ $? -ne 1 ]; then
    exit 1
fi

slither tests/uninitialized_storage_pointer.sol --disable-solc-warnings --detectors uninitialized-storage
if [ $? -ne 1 ]; then
    exit 1
fi

slither tests/tx_origin.sol --disable-solc-warnings --detectors tx-origin
if [ $? -ne 2 ]; then
    exit 1
fi

slither tests/unused_state.sol --detectors unused-state
if [ $? -ne 1 ]; then
    exit 1
fi

slither tests/locked_ether.sol --detectors locked-ether
if [ $? -ne 1 ]; then
    exit 1
fi

slither tests/arbitrary_send.sol --disable-solc-warnings --detectors arbitrary-send
if [ $? -ne 2 ]; then
    exit 1
fi


slither tests/inline_assembly_contract.sol --disable-solc-warnings --detectors assembly
if [ $? -ne 1 ]; then
    exit 1
fi

slither tests/inline_assembly_library.sol --disable-solc-warnings --detectors assembly
if [ $? -ne 2 ]; then
    exit 1
fi

slither tests/naming_convention.sol --disable-solc-warnings --detectors naming-convention
if [ $? -ne 10 ]; then
    exit 1
fi

slither tests/low_level_calls.sol --disable-solc-warnings --detectors low-level-calls
if [ $? -ne 1 ]; then
    exit 1
fi

slither tests/const_state_variables.sol --detectors const-candidates-state
if [ $? -ne 2 ]; then
    exit 1
fi


### Test scripts

python examples/scripts/functions_called.py examples/scripts/functions_called.sol
if [ $? -ne 0 ]; then
    exit 1
fi

python examples/scripts/functions_writing.py examples/scripts/functions_writing.sol
if [ $? -ne 0 ]; then
    exit 1
fi

python examples/scripts/variable_in_condition.py examples/scripts/variable_in_condition.sol
if [ $? -ne 0 ]; then
    exit 1
fi
exit 0
