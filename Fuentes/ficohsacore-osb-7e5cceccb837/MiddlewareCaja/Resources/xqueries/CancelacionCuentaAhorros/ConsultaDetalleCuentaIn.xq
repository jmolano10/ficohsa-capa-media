(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns1:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$cancelaciondecuentaparte2Response" element="ns0:Cancelaciondecuentaparte2Response" location="../../xsds/CancelacionCuenta/XMLSchema_1790235882.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadedetallesdelacuenta" location="../../xsds/ConsultasCuenta/XMLSchema_378991004.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/CancelacionCuentaAhorros/ConsultaDetalleCuentaIn/";

declare function xf:ConsultaDetalleCuentaIn($autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader),
    $cancelaciondecuentaparte2Response as element(ns0:Cancelaciondecuentaparte2Response))
    as element(ns0:Consultadedetallesdelacuenta) {
        <ns0:Consultadedetallesdelacuenta>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <WSACCOUNTLISTType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    {
                        for $ACCOUNT1 in $cancelaciondecuentaparte2Response/TELLERType/gACCOUNT1/mACCOUNT1[1]/ACCOUNT1
                        return
                            <criteriaValue>{ data($ACCOUNT1) }</criteriaValue>
                    }
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSACCOUNTLISTType>
        </ns0:Consultadedetallesdelacuenta>
};

declare variable $autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader) external;
declare variable $cancelaciondecuentaparte2Response as element(ns0:Cancelaciondecuentaparte2Response) external;

xf:ConsultaDetalleCuentaIn($autenticacionRequestHeader,
    $cancelaciondecuentaparte2Response)