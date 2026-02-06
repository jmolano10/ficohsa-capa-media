xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoDET" element="ns2:pagoDET" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns3:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/DEI/pagoDET/validarPagoDET/xsd/validarPagoDET_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/DEI/pagoDET/realizarPagoDET/xsd/realizarPagoDET_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/realizarPagoDET";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validarPagoDET";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoDETDEI/xq/realizarPagoDETDEIIn/";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/autType";

declare function xf:realizarPagoDETDEIIn($pagoDET as element(ns2:pagoDET),
    $requestHeader as element(ns3:RequestHeader),
    $outputParameters as element(ns1:OutputParameters),
    $TRANSACTIONID as xs:string,
    $fechaRegistro as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PT_AUDITORIAINFO>
                <ns0:RTN>{ data($pagoDET/RTN) }</ns0:RTN>
                <ns0:USUARIO_SERVICIO>{ data($requestHeader/Authentication/UserName) }</ns0:USUARIO_SERVICIO>
                <ns0:PROCESO_ORIGEN_ERROR>REALIZAR PAGO DET</ns0:PROCESO_ORIGEN_ERROR>
            </ns0:PT_AUDITORIAINFO>
            <ns0:PV_CODIGOCLIENTE>{ data($pagoDET/CUSTOMER_ID) }</ns0:PV_CODIGOCLIENTE>
            <ns0:PV_NUMEROCONTRATO>{ data($pagoDET/CONTRACT_NUMBER) }</ns0:PV_NUMEROCONTRATO>
            <ns0:PN_NUMEROSOLICITUD>{ data($pagoDET/BANK_BATCH_ID) }</ns0:PN_NUMEROSOLICITUD>
            <ns0:PV_DECLARACIONJURIDICA>{ data($pagoDET/JURIDICAL_DECLARATION_ID) }</ns0:PV_DECLARACIONJURIDICA>
            <ns0:PV_PERIODO>{ data($pagoDET/PERIOD) }</ns0:PV_PERIODO>
            <ns0:PN_IMPUESTOAPAGAR>{ data($pagoDET/TAX_PAYMENT_ID) }</ns0:PN_IMPUESTOAPAGAR>
            <ns0:PN_NUMEROCONCEPTOIMPUESTO>{ data($pagoDET/TAX_CONCEPT_ID) }</ns0:PN_NUMEROCONCEPTOIMPUESTO>
            <ns0:PN_TOTALINFORMADOIMPUESTO>{ data($pagoDET/TOTAL_PRESENTED) }</ns0:PN_TOTALINFORMADOIMPUESTO>
            <ns0:PN_TOTALPAGO>{ data($pagoDET/TOTAL_PAYMENT) }</ns0:PN_TOTALPAGO>
            <ns0:PV_DECLAODECLARAPAGO>{ data($pagoDET/REQUEST_DET_TYPE) }</ns0:PV_DECLAODECLARAPAGO>
            {
                for $PN_LINEADEI in $outputParameters/ns1:PN_LINEADEI
                return
                    <ns0:PN_ENLINEA>{ data($PN_LINEADEI) }</ns0:PN_ENLINEA>
            }
            {
                for $PV_CONTRATOT24 in $outputParameters/ns1:PV_CONTRATOT24
                return
                    <ns0:PV_CONTRATOT24>{ data($PV_CONTRATOT24) }</ns0:PV_CONTRATOT24>
            }
            <ns0:PV_CODIGOMONEDA>{ data($pagoDET/CURRENCY) }</ns0:PV_CODIGOMONEDA>
            <ns0:PV_NUMEROCUENTA>
            {
             let $PV_TIPO_PRODUCTO := $pagoDET/PAYMENT_INFORMATION/PAYMENT_METHOD/text()
                return
                if ($PV_TIPO_PRODUCTO = 'CREDIT_CARD') then
                 (
                    data($pagoDET/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER/text()) 
                 )
                 else(
                    data($pagoDET/ACCOUNT_NUMBER/text())
                 )  
                }
             </ns0:PV_NUMEROCUENTA>
            <ns0:PV_TRANSACCIONID>{ $TRANSACTIONID }</ns0:PV_TRANSACCIONID>
            <ns0:PV_IDUSUARIO>{ data($pagoDET/USER_ID) }</ns0:PV_IDUSUARIO>
            <ns0:PD_FECHAREGISTRO>{ fn-bea:dateTime-from-string-with-format("yyyyMMddHHmm", $fechaRegistro) }</ns0:PD_FECHAREGISTRO>           
             <ns0:PT_TARPAGODETALLE>
               {
                for $i in 1 to count($pagoDET/PAYMENT_DETAILS/PAYMENT_DETAIL)
                return
             <ns0:ITEM>
                     <ns0:IMPUESTO>{ data($pagoDET/PAYMENT_DETAILS/PAYMENT_DETAIL[$i]/TAX) }</ns0:IMPUESTO>
                     <ns0:CONCEPTO>{ data($pagoDET/PAYMENT_DETAILS/PAYMENT_DETAIL[$i]/CONCEPT) }</ns0:CONCEPTO>
                     <ns0:SUBCONCEPTO>{ data($pagoDET/PAYMENT_DETAILS/PAYMENT_DETAIL[$i]/SUB_CONCEPT) }</ns0:SUBCONCEPTO>
                     <ns0:IMPORTE>{ data($pagoDET/PAYMENT_DETAILS/PAYMENT_DETAIL[$i]/AMOUNT) }</ns0:IMPORTE>
            </ns0:ITEM>
             }
             </ns0:PT_TARPAGODETALLE>
        </ns0:InputParameters>
};

declare variable $pagoDET as element(ns2:pagoDET) external;
declare variable $requestHeader as element(ns3:RequestHeader) external;
declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $TRANSACTIONID as xs:string external;
declare variable $fechaRegistro as xs:string external;

xf:realizarPagoDETDEIIn($pagoDET,
    $requestHeader,
    $outputParameters,
    $TRANSACTIONID,
    $fechaRegistro)