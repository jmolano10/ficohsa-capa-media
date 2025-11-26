(:: pragma bea:global-element-parameter parameter="$transferenciaentrecuentas" element="ns0:Transferenciaentrecuentas" location="../../xsds/Transferencias/XMLSchema_1840876228.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadedetallesdelacuenta" location="../../xsds/ConsultasCuenta/XMLSchema_378991004.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/TransferenciaEntreCuentas/ConsultaDeDetallesDeLaCuentaIn/";

declare function xf:ConsultaDeDetallesDeLaCuentaIn($transferenciaentrecuentas as element(ns0:Transferenciaentrecuentas),
    $ACCOUNT as xs:string)
    as element(ns0:Consultadedetallesdelacuenta) {
        <ns0:Consultadedetallesdelacuenta>
            {
                for $WebRequestCommon in $transferenciaentrecuentas/WebRequestCommon
                return
                    <WebRequestCommon>{ $WebRequestCommon/@* , $WebRequestCommon/node() }</WebRequestCommon>
            }
            <WSACCOUNTLISTType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ $ACCOUNT }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSACCOUNTLISTType>
        </ns0:Consultadedetallesdelacuenta>
};

declare variable $transferenciaentrecuentas as element(ns0:Transferenciaentrecuentas) external;
declare variable $ACCOUNT as xs:string external;

xf:ConsultaDeDetallesDeLaCuentaIn($transferenciaentrecuentas,
    $ACCOUNT)