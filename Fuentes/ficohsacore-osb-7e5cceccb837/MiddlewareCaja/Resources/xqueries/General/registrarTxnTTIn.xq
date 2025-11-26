(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../xsds/General/Autenticacion_v2.xsd" ::)
(:: pragma bea:local-element-parameter parameter="$tELLERType1" type="ns1:RetiroenmonedalocalResponse/TELLERType" location="../../xsds/RetirosYPagos/XMLSchema_1006378181.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../xsds/RegistrarTxnCaja/RegistrarTxnCaja_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarTxnCaja";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/General/registrarTxnTTIn/";

declare function xf:registrarTxnTTIn($uuid as xs:string,
    $tellerTxnId as xs:string,
    $authorizer as xs:string?,
    $requestHeader1 as element(ns2:RequestHeader),
    $tELLERType1 as element())
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_IDUNICO>{ $uuid }</ns0:PV_IDUNICO>
            <ns0:PV_IDCAJERO>{ data($requestHeader1/TellerInfo/TellerId) }</ns0:PV_IDCAJERO>
            <ns0:PN_TXNCAJA>{ $tellerTxnId }</ns0:PN_TXNCAJA>
            {
                for $CURRENCY2 in $tELLERType1/CURRENCY2
                return
                    <ns0:PV_MONEDA>{ data($CURRENCY2) }</ns0:PV_MONEDA>
            }
            <ns0:PN_MONTO>
            {
            	let $TXN_CURRENCY := fn:string($tELLERType1/CURRENCY2/text())
            	return
            		if ($TXN_CURRENCY = "HNL") then (
            			fn:string($tELLERType1/AMOUNTLOCAL2/text())
            		) else (
					    fn:string($tELLERType1/AMOUNTFCY2/text())
					)
            }
            </ns0:PN_MONTO>
            {
                for $id in $tELLERType1/@id
                return
                    <ns0:PV_TXNIDT24>{ data($id) }</ns0:PV_TXNIDT24>
            }
            <ns0:PD_FECHAT24>
            { 
            	let $T24_DATE := fn:string($tELLERType1/VALUEDATE2/text())
            	return
            		fn:concat(fn:substring($T24_DATE,1,4),"-",fn:substring($T24_DATE,5,2),"-",fn:substring($T24_DATE,7,2)) 
            }
            </ns0:PD_FECHAT24>
            <ns0:PV_AUTORIZADOR>{ $authorizer }</ns0:PV_AUTORIZADOR>
        </ns0:InputParameters>
};

declare variable $uuid as xs:string external;
declare variable $tellerTxnId as xs:string external;
declare variable $authorizer as xs:string external;
declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $tELLERType1 as element() external;

xf:registrarTxnTTIn($uuid,
    $tellerTxnId,
    $authorizer,
    $requestHeader1,
    $tELLERType1)