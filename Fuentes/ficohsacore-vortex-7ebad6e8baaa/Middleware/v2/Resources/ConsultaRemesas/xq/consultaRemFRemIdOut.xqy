xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/consultarRemFRemXPagador/xsd/consultarRemFRemXPagador_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaRemesasResponse" location="../xsd/consultaRemesasTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesas/xq/consultaRemFRemIdOut/";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarRemFRemXPagador";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesasTypes";

declare function xf:consultaRemFRemIdOut($outputParameters1 as element(ns1:OutputParameters))
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
	                            for $PV_CLAVE_ITEM in $outputParameters1/ns1:PV_CODREMESADORA/ns1:PV_CLAVE_ITEM
	                            return
	                                <REMITTER_ID>{ data($PV_CLAVE_ITEM) }</REMITTER_ID>
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
	                            for $PV_CLAVE_ITEM in $outputParameters1/ns1:PV_AGENCIA_PAGO/ns1:PV_CLAVE_ITEM
	                            return
	                                <BRANCH_NAME>{ data($PV_CLAVE_ITEM) }</BRANCH_NAME>
	                        return
	                            $result[1]
	                    }
	                     {
	                        let $result :=
	                            for $PV_CLAVE_ITEM in $outputParameters1/ns1:PV_FECHA_PAGO/ns1:PV_CLAVE_ITEM
	                            return
	                                <PAYMENT_DATE>{ data($PV_CLAVE_ITEM) }</PAYMENT_DATE>
	                        return
	                            $result[1]
	                    }
	                    {
	                        let $result :=
	                            for $PV_CLAVE_ITEM in $outputParameters1/ns1:PV_MONEDA/ns1:PV_CLAVE_ITEM
	                            return
	                                <CURRENCY>{ data($PV_CLAVE_ITEM) }</CURRENCY>
	                        return
	                            $result[1]
	                    }	
	                    {
	                        let $result :=
	                            for $PV_CLAVE_ITEM in $outputParameters1/ns1:PN_TASACAMBIO/ns1:PN_TASACAMBIO_ITEM
	                            return
	                                <EXCHANGE_RATE>{ data($PV_CLAVE_ITEM) }</EXCHANGE_RATE>
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
	                            for $PV_CLAVE_ITEM in $outputParameters1/ns1:PN_VALOR/ns1:PN_TASACAMBIO_ITEM
	                            return
	                                <REMITTANCE_AMOUNT>{ data($PV_CLAVE_ITEM) }</REMITTANCE_AMOUNT>
	                        return
	                            $result[1]
	                    }
	                    <REMITTANCE_SOURCE_AMOUNT></REMITTANCE_SOURCE_AMOUNT>    	
	                </ns0:consultaRemesasResponseRecordType>
	            </ns0:consultaRemesasResponseType>
	        </ns0:consultaRemesasResponse>
        ) else (
        	<ns0:consultaRemesasResponse/>
        )
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:consultaRemFRemIdOut($outputParameters1)