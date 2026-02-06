xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoROP" element="ns1:pagoROP" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/DEI/pagoROP/realizarPagoROP/xsd/realizarPagoROP_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/realizarPagoROP";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoROPDEI/xq/realizaPagoROPDEIIn/";

declare function xf:realizaPagoROPDEIIn($pagoROP as element(ns1:pagoROP),
    $requestHeader as element(ns2:RequestHeader),
    $T24Contract as xs:string,
    $TransactionID as xs:string,
    $fechaRegistro as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CODIGOUSUARIO>{ data($pagoROP/USER_ID) }</ns0:PV_CODIGOUSUARIO>
            <ns0:PT_AUDITORIAINFO>
                <ns0:RTN>{ data($pagoROP/RTN) }</ns0:RTN>
                <ns0:USUARIO_SERVICIO>{ data($requestHeader/Authentication/UserName) }</ns0:USUARIO_SERVICIO>
                <ns0:PROCESO_ORIGEN_ERROR>PagoROPDEI</ns0:PROCESO_ORIGEN_ERROR>
            </ns0:PT_AUDITORIAINFO>
            <ns0:PV_CODIGOCLIENTEBANCO>{ data($pagoROP/CUSTOMER_ID) }</ns0:PV_CODIGOCLIENTEBANCO>
            <ns0:PV_TIPOPERSONA>{ data($pagoROP/PERSON_TYPE) }</ns0:PV_TIPOPERSONA>
            <ns0:PV_CODIGOISOMONEDA>{ data($pagoROP/CURRENCY) }</ns0:PV_CODIGOISOMONEDA>
            <ns0:PD_FECHAREGISTRO>{ fn-bea:dateTime-from-string-with-format("yyyyMMddHHmm", $fechaRegistro) }</ns0:PD_FECHAREGISTRO>
            <ns0:PN_MES>{ data($pagoROP/MONTH) }</ns0:PN_MES>
            <ns0:PN_CODIGOCONCEPTO>{ data($pagoROP/TAX_CONCEPT_ID) }</ns0:PN_CODIGOCONCEPTO>
            <ns0:PN_CODIGOIMPUESTO>{ data($pagoROP/TAX_PAYMENT_ID) }</ns0:PN_CODIGOIMPUESTO>
            <ns0:PN_ANIO>{ data($pagoROP/YEAR) }</ns0:PN_ANIO>
            <ns0:PN_TOTALAPAGAR>{ data($pagoROP/TOTAL_PAYMENT) }</ns0:PN_TOTALAPAGAR>
            <ns0:PN_MONTODEBITAR>{ data($pagoROP/AMOUNT) }</ns0:PN_MONTODEBITAR>
            <ns0:PN_MULTA>{ data($pagoROP/PENALTY_FEE) }</ns0:PN_MULTA>
            <ns0:PN_RECARGO>{ data($pagoROP/SURCHARGE_PAYMENT) }</ns0:PN_RECARGO>
            <ns0:PN_INTERESES>{ data($pagoROP/INTEREST_PAYMENT) }</ns0:PN_INTERESES>
            <ns0:PV_CONTRATOT24>{ $T24Contract }</ns0:PV_CONTRATOT24>
            <ns0:PV_IDTRANSACCION>{ $TransactionID }</ns0:PV_IDTRANSACCION>
        </ns0:InputParameters>
};

declare variable $pagoROP as element(ns1:pagoROP) external;
declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $T24Contract as xs:string external;
declare variable $TransactionID as xs:string external;
declare variable $fechaRegistro as xs:string external;

xf:realizaPagoROPDEIIn($pagoROP,
    $requestHeader,
    $T24Contract,
    $TransactionID,
    $fechaRegistro)