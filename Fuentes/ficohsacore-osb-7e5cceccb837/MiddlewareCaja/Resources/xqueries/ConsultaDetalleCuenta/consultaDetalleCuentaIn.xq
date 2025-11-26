(:: pragma bea:global-element-return element="ns0:Consultadedetallesdelacuenta" location="../../xsds/ConsultasCuenta/XMLSchema_378991004.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaDetalleCuenta/consultaDetalleCuentaIn/";

declare function xf:consultaDetalleCuentaIn($username as xs:string,
    $password as xs:string,
    $accountNumber as xs:string)
    as element(ns0:Consultadedetallesdelacuenta) {
        <ns0:Consultadedetallesdelacuenta>
            <WebRequestCommon>
                <userName>{ $username }</userName>
                <password>{ $password }</password>
            </WebRequestCommon>
            <WSACCOUNTLISTType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ $accountNumber }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSACCOUNTLISTType>
        </ns0:Consultadedetallesdelacuenta>
};

declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $accountNumber as xs:string external;

xf:consultaDetalleCuentaIn($username,
    $password,
    $accountNumber)