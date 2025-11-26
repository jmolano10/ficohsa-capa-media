(:: pragma bea:global-element-parameter parameter="$retiroDeCuenta1" element="ns1:retiroDeCuenta" location="../../xsds/RetiroDeCuenta/RetiroDeCuenta.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Retirodeefecenmonextranjera" location="../../xsds/RetirosYPagos/XMLSchema_1006378181.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/retiroDeCuenta";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RetiroDeCuenta/retiroDeCuentaFcyIn/";

declare function xf:retiroDeCuentaFcyIn($retiroDeCuenta1 as element(ns1:retiroDeCuenta),
    $uuid as xs:string,
    $username as xs:string,
    $password as xs:string)
    as element(ns0:Retirodeefecenmonextranjera) {
        <ns0:Retirodeefecenmonextranjera>
            <WebRequestCommon>
                <userName>{ $username }</userName>
                <password>{ $password }</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl/>
                <messageId>{ $uuid }</messageId>
                <noOfAuth/>
                <replace/>
            </OfsFunction>
            <TELLERFICOHNFCYCASHType>
                <WithdrawalCurrency>{ data($retiroDeCuenta1/WITHDRAWAL_CURRENCY) }</WithdrawalCurrency>
                <gACCOUNT1>
                    <mACCOUNT1>
                        <WithdrawalAmount>{ data($retiroDeCuenta1/WITHDRAWAL_AMOUNT) }</WithdrawalAmount>
                    </mACCOUNT1>
                </gACCOUNT1>
                <Account>{ data($retiroDeCuenta1/ACCOUNT_NUMBER) }</Account>
                <gNARRATIVE2>
                    {
                        for $DESCRIPTION in $retiroDeCuenta1/DESCRIPTION
                        return
                            <Narrative>{ data($DESCRIPTION) }</Narrative>
                    }
                </gNARRATIVE2>
            </TELLERFICOHNFCYCASHType>
        </ns0:Retirodeefecenmonextranjera>
};

declare variable $retiroDeCuenta1 as element(ns1:retiroDeCuenta) external;
declare variable $uuid as xs:string external;
declare variable $username as xs:string external;
declare variable $password as xs:string external;

xf:retiroDeCuentaFcyIn($retiroDeCuenta1,
    $uuid,
    $username,
    $password)