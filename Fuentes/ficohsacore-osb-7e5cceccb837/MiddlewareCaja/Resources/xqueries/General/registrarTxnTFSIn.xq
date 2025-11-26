(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../xsds/General/Autenticacion_v2.xsd" ::)
(:: pragma bea:schema-type-parameter parameter="$tELLERFINANCIALSERVICESType1" type="ns1:TELLERFINANCIALSERVICESType" location="../../xsds/Depositos/XMLSchema_-420276392.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../xsds/RegistrarTxnCaja/RegistrarTxnCaja_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarTxnCaja";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/General/registrarTxnTFSIn/";

declare function xf:registrarTxnTFSIn($uuid as xs:string,
    $TFSTxnId as xs:string,
    $authorizer as xs:string,
    $requestHeader1 as element(ns2:RequestHeader),
    $tELLERFINANCIALSERVICESType1 as element())
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_IDUNICO>{ $uuid }</ns0:PV_IDUNICO>
            <ns0:PV_IDCAJERO>{ data($requestHeader1/TellerInfo/TellerId) }</ns0:PV_IDCAJERO>
            <ns0:PN_TXNCAJA>{ $TFSTxnId }</ns0:PN_TXNCAJA>
            {
                for $CURRENCY in $tELLERFINANCIALSERVICESType1/LRCRCCY
                return
                    <ns0:PV_MONEDA>{ data($CURRENCY) }</ns0:PV_MONEDA>
            }
            {
			for $MONTO in $tELLERFINANCIALSERVICESType1/LRCONSOLTOT
                return
                    <ns0:PN_MONTO>{ data($MONTO) }</ns0:PN_MONTO>
           	}
            {
                for $id in $tELLERFINANCIALSERVICESType1/@id
                return
                    <ns0:PV_TXNIDT24>{ data($id) }</ns0:PV_TXNIDT24>
            }
            <ns0:PD_FECHAT24>
            { 
            	let $T24_DATE := fn:string($tELLERFINANCIALSERVICESType1/gTRANSACTION/mTRANSACTION[1]/CRVALUEDATE/text())
            	return
            		fn:concat(fn:substring($T24_DATE,1,4),"-",fn:substring($T24_DATE,5,2),"-",fn:substring($T24_DATE,7,2)) 
            }
            </ns0:PD_FECHAT24>            
            <ns0:PV_AUTORIZADOR>{ $authorizer }</ns0:PV_AUTORIZADOR>
        </ns0:InputParameters>
};

declare variable $uuid as xs:string external;
declare variable $TFSTxnId as xs:string external;
declare variable $authorizer as xs:string external;
declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $tELLERFINANCIALSERVICESType1 as element() external;

xf:registrarTxnTFSIn($uuid,
    $TFSTxnId,
    $authorizer,
    $requestHeader1,
    $tELLERFINANCIALSERVICESType1)