(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../xsds/General/Autenticacion_v2.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$depositoChequeGerencia1" element="ns1:depositoChequeGerencia" location="../../xsds/DepositoChequeGerencia/DepositoChequeGerencia.xsd" ::)
(:: pragma bea:global-element-return element="ns0:DepositoChequeGerenciaFCY" location="../../xsds/TransaccionesAutobancos/XMLSchema_1271081668.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/depositoChequeGerencia";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoChequeGerencia/depositoChequeGerenciaFcyIn/";

declare function xf:depositoChequeGerenciaFcyIn($requestHeader1 as element(ns2:RequestHeader),
    $depositoChequeGerencia1 as element(ns1:depositoChequeGerencia),
    $nostroAccount as xs:string,
    $chequeAmount as xs:string,
    $uuid as xs:string)
    as element(ns0:DepositoChequeGerenciaFCY) {
        <ns0:DepositoChequeGerenciaFCY>
            <WebRequestCommon>
                <userName>{ data($requestHeader1/Authentication/UserName) }</userName>
                <password>{ data($requestHeader1/Authentication/Password) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <messageId>{ $uuid }</messageId>
            </OfsFunction>
            <TELLERFICOHNDEPINTWSType>
                <Ccy>{ data($depositoChequeGerencia1/CURRENCY) }</Ccy>
                <gACCOUNT1>
                    <mACCOUNT1>
                        <Account>{ $nostroAccount }</Account>
                        <AmountFcy1>{ $chequeAmount }</AmountFcy1>
                    </mACCOUNT1>
                </gACCOUNT1>
                <Account2>{ data($depositoChequeGerencia1/DEPOSIT_ACCOUNT) }</Account2>
                <gNARRATIVE2>
                    {
                        for $DESCRIPTION in $depositoChequeGerencia1/DESCRIPTION
                        return
                            <Description>{ data($DESCRIPTION) }</Description>
                    }
                </gNARRATIVE2>
                <gCHEQUENUMBER>
                    <mCHEQUENUMBER>
                        <ChequeNo>{ data($depositoChequeGerencia1/CHEQUE_NUMBER) }</ChequeNo>
                    </mCHEQUENUMBER>
                </gCHEQUENUMBER>
                {
                    for $DEPOSITOR_ID in $depositoChequeGerencia1/DEPOSITOR_ID
                    return
                        <LRBENID>{ data($DEPOSITOR_ID) }</LRBENID>
                }
                {
                    for $DEPOSITOR_NAME in $depositoChequeGerencia1/DEPOSITOR_NAME
                    return
                        <LRBENNAME>{ data($DEPOSITOR_NAME) }</LRBENNAME>
                }
                {
                    for $CHANNEL in $depositoChequeGerencia1/CHANNEL
                    return
                        <LRCHANNELID>{ data($CHANNEL) }</LRCHANNELID>
                }
            </TELLERFICOHNDEPINTWSType>
        </ns0:DepositoChequeGerenciaFCY>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $depositoChequeGerencia1 as element(ns1:depositoChequeGerencia) external;
declare variable $nostroAccount as xs:string external;
declare variable $chequeAmount as xs:string external;
declare variable $uuid as xs:string external;

xf:depositoChequeGerenciaFcyIn($requestHeader1,
    $depositoChequeGerencia1,
    $nostroAccount,
    $chequeAmount,
    $uuid)
