(:: pragma bea:global-element-parameter parameter="$retiroDeDepositoGarantia" element="ns1:retiroDeDepositoGarantia" location="../../xsds/RetiroDeDepositoGarantia/retiroDeDepositoGarantiaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Retiroenmonedalocal" location="../../xsds/RetirosYPagos/XMLSchema_1006378181.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/retiroDeDepositoGarantiaTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RetiroDeDepositoGarantia/retiroDeDepositoGarantiaIn/";

declare function xf:retiroDeDepositoGarantiaIn($retiroDeDepositoGarantia as element(ns1:retiroDeDepositoGarantia),
    $uuid as xs:string,
    $userName as xs:string,
    $password as xs:string,
    $debitAccount as xs:string)
    as element(ns0:Retiroenmonedalocal) {
        <ns0:Retiroenmonedalocal>
            <WebRequestCommon>
                <userName>{ $userName }</userName>
                <password>{ $password }</password>
            </WebRequestCommon>
            <OfsFunction>
                <messageId>{ $uuid }</messageId>
            </OfsFunction>
            <TELLERFICOLCYCASHWDLWSType>
                <gACCOUNT1>
                    <mACCOUNT1>
                        <AMOUNTLOCAL1>{ data($retiroDeDepositoGarantia/AMOUNT) }</AMOUNTLOCAL1>
                    </mACCOUNT1>
                </gACCOUNT1>
                <ACCOUNT2> {$debitAccount} </ACCOUNT2>
            </TELLERFICOLCYCASHWDLWSType>
        </ns0:Retiroenmonedalocal>
};

declare variable $retiroDeDepositoGarantia as element(ns1:retiroDeDepositoGarantia) external;
declare variable $uuid as xs:string external;
declare variable $userName as xs:string external;
declare variable $password as xs:string external;
declare variable $debitAccount as xs:string external;

xf:retiroDeDepositoGarantiaIn($retiroDeDepositoGarantia,
    $uuid,
    $userName,
    $password,
    $debitAccount)
