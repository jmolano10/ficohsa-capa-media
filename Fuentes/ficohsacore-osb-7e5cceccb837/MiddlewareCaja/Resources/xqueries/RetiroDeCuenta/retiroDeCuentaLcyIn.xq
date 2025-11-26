(:: pragma bea:global-element-parameter parameter="$retiroDeCuenta1" element="ns1:retiroDeCuenta" location="../../xsds/RetiroDeCuenta/RetiroDeCuenta.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Retiroenmonedalocal" location="../../xsds/RetirosYPagos/XMLSchema_1006378181.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/retiroDeCuenta";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RetiroDeCuenta/retiroDeCuentaLcyIn/";

declare function xf:retiroDeCuentaLcyIn($retiroDeCuenta1 as element(ns1:retiroDeCuenta), 
	$uuid as xs:string,
    $username as xs:string,
    $password as xs:string)
    as element(ns0:Retiroenmonedalocal) {
        <ns0:Retiroenmonedalocal>
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
            <TELLERFICOLCYCASHWDLWSType>
                <gACCOUNT1>
                    <mACCOUNT1>
                        <AMOUNTLOCAL1>{ data($retiroDeCuenta1/WITHDRAWAL_AMOUNT) }</AMOUNTLOCAL1>
                    </mACCOUNT1>
                </gACCOUNT1>
                <ACCOUNT2>{ data($retiroDeCuenta1/ACCOUNT_NUMBER) }</ACCOUNT2>
                <gNARRATIVE2>
                    {
                        for $DESCRIPTION in $retiroDeCuenta1/DESCRIPTION
                        return
                            <NARRATIVE>{ data($DESCRIPTION) }</NARRATIVE>
                    }
                </gNARRATIVE2>
            </TELLERFICOLCYCASHWDLWSType>
        </ns0:Retiroenmonedalocal>
};

declare variable $retiroDeCuenta1 as element(ns1:retiroDeCuenta) external;
declare variable $uuid as xs:string external;
declare variable $username as xs:string external;
declare variable $password as xs:string external;

xf:retiroDeCuentaLcyIn($retiroDeCuenta1,
	$uuid,
	$username,
	$password)