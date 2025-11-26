(:: pragma bea:global-element-parameter parameter="$consultaDocumento" element="ns0:consultaDocumento" location="../../ConsultaChequesCompensacion/xsd/consultaChequesCompensacionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/consultaDocumento/xsd/consultaDocumento_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaChequesCompensacionTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDocumento";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDocumento/xq/consultaDocumentoGTIn/";

declare function xf:consultaDocumentoGTIn($consultaDocumento as element(ns0:consultaDocumento))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PN_BRANCH>{ data($consultaDocumento/BRANCH) }</ns1:PN_BRANCH>
            <ns1:PN_JOURNAL>{ data($consultaDocumento/JOURNAL) }</ns1:PN_JOURNAL>
            {
                for $TELLER in $consultaDocumento/TELLER
                return
                if(string($TELLER/text()) != "") then(
                    <ns1:PV_TELLER>{ data($TELLER) }</ns1:PV_TELLER>
                )else()
            }
            <ns1:PV_CURRENCY>{ data($consultaDocumento/CURRENCY) }</ns1:PV_CURRENCY>
            <ns1:PD_DATE>
                {
                    fn-bea:dateTime-from-string-with-format(
                    "yyyy-MM-dd",
                    fn-bea:date-to-string-with-format(
                    "yyyy-MM-dd",
                    data($consultaDocumento/DATE)
                    )
                    )
                }
			</ns1:PD_DATE>
            <ns1:PV_TYPE>{ data($consultaDocumento/TYPE) }</ns1:PV_TYPE>
        </ns1:InputParameters>
};

declare variable $consultaDocumento as element(ns0:consultaDocumento) external;

xf:consultaDocumentoGTIn($consultaDocumento)
