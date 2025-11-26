(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../Resoruces/ConsultarRemLocalId/consultarRemLocalId_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaRemesasResponse" location="consultaRemesasTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarRemLocalId";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesasTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/remesas/ConsultaRemesas/consultaRemLocalIdOut/";

declare function xf:consultaRemLocalIdOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:consultaRemesasResponse) {
    	if (fn:string($outputParameters1/ns1:PV_ERROR/text()) = "") then (
	        <ns0:consultaRemesasResponse>
	            <ns0:consultaRemesasResponseType>
	                <ns0:consultaRemesasResponseRecordType>
	                    {
	                        let $result :=
	                            for $PV_CLAVE_ITEM in $outputParameters1/ns1:PV_CLAVE/ns1:PV_CLAVE_ITEM
	                            return
	                                <REMITTANCE_ID>{ data($PV_CLAVE_ITEM) }</REMITTANCE_ID>
	                        return
	                            $result[1]
	                    }
	                    {
	                        let $result :=
	                            for $PV_CLAVE_ITEM in $outputParameters1/ns1:PV_REMITENTE/ns1:PV_CLAVE_ITEM
	                            return
	                                <REMITTER_NAME>{ data($PV_CLAVE_ITEM) }</REMITTER_NAME>
	                        return
	                            $result[1]
	                    }
	                    {
	                        let $result :=
	                            for $PV_CLAVE_ITEM in $outputParameters1/ns1:PV_BENEFICIARIO/ns1:PV_CLAVE_ITEM
	                            return
	                                <BENEFICIARY_NAME>{ data($PV_CLAVE_ITEM) }</BENEFICIARY_NAME>
	                        return
	                            $result[1]
	                    }
	                    {
	                        let $result :=
	                            for $PV_CLAVE_ITEM in $outputParameters1/ns1:PV_ESTADO/ns1:PV_CLAVE_ITEM
	                            return
	                                <REMITTANCE_STATUS>{ data($PV_CLAVE_ITEM) }</REMITTANCE_STATUS>
	                        return
	                            $result[1]
	                    }                	
	                    {
	                        let $result :=
	                            for $PV_CLAVE_ITEM in $outputParameters1/ns1:PV_VALOR/ns1:PV_VALOR_ITEM
	                            return
	                                <REMITTANCE_AMOUNT>{ data($PV_CLAVE_ITEM) }</REMITTANCE_AMOUNT>
	                        return
	                            $result[1]
	                    }
	                </ns0:consultaRemesasResponseRecordType>
	            </ns0:consultaRemesasResponseType>
	        </ns0:consultaRemesasResponse>
        ) else (
        	<ns0:consultaRemesasResponse/>
        )
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:consultaRemLocalIdOut($outputParameters1)