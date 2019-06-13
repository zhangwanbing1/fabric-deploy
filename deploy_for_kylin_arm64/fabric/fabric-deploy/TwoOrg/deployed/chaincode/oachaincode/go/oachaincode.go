
package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"github.com/hyperledger/fabric/core/chaincode/shim"
	pb "github.com/hyperledger/fabric/protos/peer"
	"log"
	"strconv"
)

func init(){
	log.SetPrefix("OAChaincode LOG: ")
	log.SetFlags(log.Ldate | log.Lmicroseconds | log.Llongfile)
	log.Println("init started")
}

type OaChaincode struct {
}

type OaClaim struct {
	DataType string `json:"dataType"`
	JsonString string `json:"jsonString"`
	ExtInfo string `json:"extInfo"`
	UdfsHash string `json:"udfsHash"`
}

func initHelp() string {
	return "\nUsage: {\"Args\":[\"init/insert\",\"dataID\", \"dataType\", \"jsonString\",\"extInfo\", \"udfsHash\"]}\n"
}

func updateHelp() string {
	return "\nUsage: {\"Args\":[\"update\",\"dataID\", \"dataType\", \"jsonString\",\"extInfo\", \"udfsHash\"]}\n"
}

func deleteQueryHelp() string {
	return "\nUsage: {\"Args\":[\"delete/query\",\"dataID\"]}\n"
}

func (t *OaChaincode) Init(stub shim.ChaincodeStubInterface) pb.Response {
	fmt.Println("ex Init")
	function, args := stub.GetFunctionAndParameters()
	if function != "init" && len(args) != 5 {
		return shim.Error("Incorrect function name or number of arguments." + initHelp())
	}

	return t.insert(stub, args)
}

func (t *OaChaincode) Invoke(stub shim.ChaincodeStubInterface) pb.Response {
	fmt.Println("ex Invoke")
	function, args := stub.GetFunctionAndParameters()
	if function == "insert" {
		return t.insert(stub, args)
	} else if function == "update" {
		return t.update(stub, args)
	} else if function == "delete" {
		return t.delete(stub, args)
	} else if function == "query" {
		return t.query(stub, args)
	} else if function == "queryAll" {
		return t.queryAll(stub, args)
	}

	return shim.Error("Unsupported method.")
}

func (t *OaChaincode) insert(stub shim.ChaincodeStubInterface, args []string) pb.Response {
	if len(args) != 5 {
		return shim.Error("Incorrect number of arguments. Expecting 5 got " + strconv.Itoa(len(args)))
	}

	dataId := args[0]
	data, err := stub.GetState(dataId)
	if err != nil {
		return shim.Error("Faled to get state")
	}
	if data != nil {
		return shim.Error("Entity already exists, try updating instead.")
	}

	var oaClaim OaClaim

	if args[1] == "null" {
		oaClaim.DataType = ""
	} else {
		oaClaim.DataType = args[1]
	}

	if args[2] == "null" || args[2] == "" {
		oaClaim.JsonString = "{}"
	} else {
		if !json.Valid([]byte(args[2])) {
			return shim.Error("Invalid JSON string")
		}
		oaClaim.JsonString = args[2]
	}

	if args[3] == "null" {
		oaClaim.ExtInfo = ""
	} else {
		oaClaim.ExtInfo = args[3]
	}

	if args[4] == "null" {
		oaClaim.UdfsHash = ""
	} else {
		oaClaim.UdfsHash = args[4]
	}

	oaClaimJsonBytes, err := json.Marshal(oaClaim)
	if err != nil {
		return shim.Error("Failed to Parse Object")
	}

	err = stub.PutState(args[0], oaClaimJsonBytes)
	if err != nil {
		return shim.Error(err.Error())
	}

	return shim.Success([]byte("Data write success."))
}

func (t *OaChaincode) delete(stub shim.ChaincodeStubInterface, args []string) pb.Response {
	if len(args) != 1 {
		return shim.Error("Incorrect number of arguments. Expecting 1, got " + strconv.Itoa(len(args)) + deleteQueryHelp())
	}
	err := stub.DelState(args[0])
	if err != nil {
		return shim.Error("Failed to delete state")
	}

	return shim.Success([]byte("Data deletion successful"))
}

func (t *OaChaincode) query(stub shim.ChaincodeStubInterface, args []string) pb.Response {
	if len(args) != 1 {
		return shim.Error("Incorrect number of arguments. Expecting ID" + deleteQueryHelp())
	}

	id := args[0]

	data, e := stub.GetState(id)
	if e != nil {
		jsonResp := "{\"Error\":\"Failed to get state for " + id + "\"}"
		return shim.Error(jsonResp)
	}

	if data == nil {
		jsonResp := "{\"Error\":\"No Entry found for " + id + "\"}"
		return shim.Error(jsonResp)
	}
	log.Println("State data: ", data)

	var oaClaim OaClaim

	err := json.Unmarshal(data, &oaClaim)
	if err != nil {
		return shim.Error("Failed to parse data")
	}

	log.Println("Adding data: ", oaClaim.DataType, oaClaim.JsonString, oaClaim.ExtInfo, oaClaim.UdfsHash)
	jsonResp := "{\"id\":\"" + id +
		"\",\"dataType\":\"" + oaClaim.DataType +
		"\",\"jsonString\":\"" + oaClaim.JsonString +
		"\",\"extInfo\":\"" + oaClaim.ExtInfo +
		"\",\"udfsHash\":\"" + oaClaim.UdfsHash +
		"\"}"
	fmt.Printf("Query Response:%s\n", jsonResp)

	return shim.Success([]byte(jsonResp))
}

func (t *OaChaincode) queryAll(stub shim.ChaincodeStubInterface, args []string) pb.Response {
	if len(args) != 2 {
		return  shim.Error("Incorrent number of arguments. Expecting 2")
	}
	resultsIterator, err := stub.GetStateByRange(args[0], args[1])
	if err != nil {
		return  shim.Error("Failed to get Claims")
	}
	defer resultsIterator.Close()

	var buffer bytes.Buffer
	buffer.WriteString("[")

	bArrayMemberAlreadyWritten := false
	for resultsIterator.HasNext() {
		queryResponse, err := resultsIterator.Next()
		if err != nil {
			return shim.Error(err.Error())
		}

		if bArrayMemberAlreadyWritten == true {
			buffer.WriteString(",")
		}

		buffer.WriteString("{\"Key\":")
		buffer.WriteString("\"")
		buffer.WriteString(queryResponse.Key)
		buffer.WriteString("\"")

		buffer.WriteString(", \"Record\":")
		buffer.WriteString(string(queryResponse.Value))
		buffer.WriteString("}")
		bArrayMemberAlreadyWritten = true
	}
	buffer.WriteString("]")

	fmt.Printf("- queryAll:\n%s\n", buffer.String())
	return shim.Success(buffer.Bytes())
}

func (t *OaChaincode) update(stub shim.ChaincodeStubInterface, args []string) pb.Response {
	if len(args) != 5 {
		return shim.Error("Incorrect number of arguments. Expecting 5 got " + strconv.Itoa(len(args)) + updateHelp())
	}

	data, err := stub.GetState(args[0])
	if err != nil {
		return shim.Error("Faled to get state")
	}
	if data == nil {
		return shim.Error("Entry does not exists")
	}

	var oaClaim OaClaim
	err = json.Unmarshal(data, &oaClaim)
	if err != nil {
		return shim.Error("Failed to parse object")
	}

	if args[1] == "null" {
		oaClaim.DataType = ""
	} else {
		oaClaim.DataType = args[1]
	}

	if args[2] == "null" || args[2] == "" {
		oaClaim.JsonString = "{}"
	} else {
		if !json.Valid([]byte(args[2])) {
			return shim.Error("Invalid JSON string")
		}
		oaClaim.JsonString = args[2]
	}

	if args[3] == "null" {
		oaClaim.ExtInfo = ""
	} else {
		oaClaim.ExtInfo = args[3]
	}

	if args[4] == "null" {
		oaClaim.UdfsHash = ""
	} else {
		oaClaim.UdfsHash = args[4]
	}

	oaClaimJsonBytes, err := json.Marshal(oaClaim)
	if err != nil {
		return shim.Error("Failed to encode object")
	}

	log.Println("Updating data: ", oaClaim.DataType, oaClaim.JsonString, oaClaim.ExtInfo, oaClaim.UdfsHash)
	err = stub.PutState(args[0], oaClaimJsonBytes)
	if err != nil {
		return shim.Error(err.Error())
	}

	return shim.Success(nil)
}

func main() {
	err := shim.Start(new(OaChaincode))
	if err != nil {
		fmt.Printf("Error starting Sample chaincode: %s", err)
	}
}

