xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaRecibo" element="ns0:consultaRecibo" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/DEI/consultarReciboImp/xsd/consultarRecibo_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarRecibo";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaReciboDEI/xq/consultaReciboDEIIn/";

declare function xf:consultaReciboDEIIn($consultaRecibo as element(ns0:consultaRecibo))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_IDRECIBO>{ data($consultaRecibo/BILL_NUMBER) }</ns1:PV_IDRECIBO>
            {
                for $TAX_TYPE in $consultaRecibo/TAX_TYPE
                return
                    <ns1:PV_TIPOIMPUESTO>{ data($TAX_TYPE) }</ns1:PV_TIPOIMPUESTO>
            }
            {
                for $USER_ID in $consultaRecibo/USER_ID
                return
                    <ns1:PV_USERID>{ data($USER_ID) }</ns1:PV_USERID>
            }
            {
                for $CUSTOMER_ID in $consultaRecibo/CUSTOMER_ID
                return
                    <ns1:PV_CODIGOCLIENTEBANCO>{ data($CUSTOMER_ID) }</ns1:PV_CODIGOCLIENTEBANCO>
            }
        </ns1:InputParameters>
};

declare variable $consultaRecibo as element(ns0:consultaRecibo) external;

xf:consultaReciboDEIIn($consultaRecibo)