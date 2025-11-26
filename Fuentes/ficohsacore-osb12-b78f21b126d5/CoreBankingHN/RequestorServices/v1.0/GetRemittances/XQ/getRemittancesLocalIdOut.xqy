xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/getRemittancesTypes";
(:: import schema at "../../../../../MWBanking/Remittances/RequestorServices/XSD/getRemittances.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/getRemittancesLocalId";
(:: import schema at "../../../../ProviderServices/XSD/GetRemittancesLocalId/getRemittancesLocalId_sp.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $getRemittancesLocalIdResponse as element() (:: schema-element(ns1:OutputParameters) ::) external;

declare function local:func($uuid as xs:string, $getRemittancesLocalIdResponse as element() (:: schema-element(ns1:OutputParameters) ::)) as element() (:: schema-element(ns2:getRemittancesResponse) ::) {
    <ns2:getRemittancesResponse>
        <ns2:getRemittancesResponseType>
            <ns2:getRemittancesResponseRecordTypes>
	                    {
	                        let $result :=
	                            for $PV_CLAVE_ITEM in $getRemittancesLocalIdResponse/ns1:PV_CLAVE/ns1:PV_CLAVE_ITEM
	                            return
	                                <RemittanceId>{ data($PV_CLAVE_ITEM) }</RemittanceId>
	                        return
	                            $result[1]
	                    }
	                    {
	                        let $result :=
	                            for $PV_CLAVE_ITEM in $getRemittancesLocalIdResponse/ns1:PV_CODREMESADORA/ns1:PV_CLAVE_ITEM
	                            return
	                                <RemitterId>{ data($PV_CLAVE_ITEM) }</RemitterId>
	                        return
	                            $result[1]
	                    }
	                    {
	                        let $result :=
	                            for $PV_CLAVE_ITEM in $getRemittancesLocalIdResponse/ns1:PV_REMITENTE/ns1:PV_CLAVE_ITEM
	                            return
	                                <RemitterName>{ data($PV_CLAVE_ITEM) }</RemitterName>
	                        return
	                            $result[1]
	                    }
	                    {
	                        let $result :=
	                            for $PV_CLAVE_ITEM in $getRemittancesLocalIdResponse/ns1:PV_BENEFICIARIO/ns1:PV_CLAVE_ITEM
	                            return
	                                <BeneficiaryName>{ data($PV_CLAVE_ITEM) }</BeneficiaryName>
	                        return
	                            $result[1]
	                    }
	                    {
	                        let $result :=
	                            for $PV_CLAVE_ITEM in $getRemittancesLocalIdResponse/ns1:PV_AGENGIA_PAGO/ns1:PV_CLAVE_ITEM
	                            return
	                                <BranchName>{ data($PV_CLAVE_ITEM) }</BranchName>
	                        return
	                            $result[1]
	                    }
	                     {
	                        let $result :=
	                            for $PV_CLAVE_ITEM in $getRemittancesLocalIdResponse/ns1:PV_FECHA_PAGO/ns1:PV_CLAVE_ITEM
	                            return
	                                <PaymentDate>{ data($PV_CLAVE_ITEM) }</PaymentDate>
	                        return
	                            $result[1]
	                    }
	                    {
	                        let $result :=
	                            for $PV_CLAVE_ITEM in $getRemittancesLocalIdResponse/ns1:PV_MONEDA/ns1:PV_CLAVE_ITEM
	                            return
	                                <Currency>{ data($PV_CLAVE_ITEM) }</Currency>
	                        return
	                            $result[1]
	                    }
	                    {	                    	
	                        let $result :=
	                            for $PV_CLAVE_ITEM in $getRemittancesLocalIdResponse/ns1:PN_TASACAMBIO/ns1:PN_TASACAMBIO_ITEM
	                            return
	                            	<ExchangeRate>{ data($PV_CLAVE_ITEM) }</ExchangeRate>
	                        return
	                            $result[1]
	                    }	                    
	                    {
	                        let $result :=
	                            for $PV_CLAVE_ITEM in $getRemittancesLocalIdResponse/ns1:PV_ESTADO/ns1:PV_CLAVE_ITEM
	                            return
	                                <RemittanceStatus>{ data($PV_CLAVE_ITEM) }</RemittanceStatus>
	                        return
	                            $result[1]
	                    }                	
	                    {
	                        let $result :=
	                            for $PV_CLAVE_ITEM in $getRemittancesLocalIdResponse/ns1:PN_VALOR/ns1:PN_TASACAMBIO_ITEM
	                            return
	                                <RemittanceAmount>{ data($PV_CLAVE_ITEM) }</RemittanceAmount>
	                        return
	                            $result[1]
	                    }
	                    <RemittanceSourceAmount></RemittanceSourceAmount> 
	                </ns2:getRemittancesResponseRecordTypes>
        </ns2:getRemittancesResponseType>
        <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
    </ns2:getRemittancesResponse>
};

local:func($uuid, $getRemittancesLocalIdResponse)
