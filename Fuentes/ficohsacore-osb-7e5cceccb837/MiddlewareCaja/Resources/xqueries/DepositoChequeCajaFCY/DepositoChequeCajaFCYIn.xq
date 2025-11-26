(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$depositoChequeCajaFCY" element="ns0:depositoChequeCajaFCY" location="../../xsds/DepositoChequeCajaFCY/DepositoChequeCajaFCY.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadechequedegerenciaFCYResponse" element="ns1:ConsultadechequedegerenciaFCYResponse" location="../../xsds/ChequeGerencia/XMLSchema_-1805424041.xsd" ::)
(:: pragma bea:global-element-return element="ns1:DepositodechequedegerenciaFCY" location="../../xsds/Depositos/XMLSchema_-420276392.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/depositoChequeCajaFCYTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoChequeCajaFCY/DepositoChequeCajaFCYIn/";

declare function xf:DepositoChequeCajaFCYIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $depositoChequeCajaFCY as element(ns0:depositoChequeCajaFCY),
    $consultadechequedegerenciaFCYResponse as element(ns1:ConsultadechequedegerenciaFCYResponse))
    as element(ns1:DepositodechequedegerenciaFCY) {
        <ns1:DepositodechequedegerenciaFCY>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl/>
                <messageId/>
                <noOfAuth/>
                <replace/>
            </OfsFunction>
            <TELLERFICOHNDEPINTWSType>
                <Currency>{ data($depositoChequeCajaFCY/CHECK_CURRENCY) }</Currency>
                <gACCOUNT1>
                    <mACCOUNT1>
                        {
                            for $Nostro in $consultadechequedegerenciaFCYResponse/FICOHNFCYDRAFTDETAILSWSType[1]/gFICOHNFCYDRAFTDETAILSWSDetailType/mFICOHNFCYDRAFTDETAILSWSDetailType[1]/Nostro
                            return
                                <Account>{ data($Nostro) }</Account>
                        }
                        <AmountFcy1>{ data($depositoChequeCajaFCY/CHECK_AMOUNT) }</AmountFcy1>
                    </mACCOUNT1>
                </gACCOUNT1>
                <Account2>{ data($depositoChequeCajaFCY/DEPOSIT_ACCOUNT) }</Account2>
                <gCHEQUENUMBER>
                    <mCHEQUENUMBER>
                        <ChequeNo>{ data($depositoChequeCajaFCY/CHECK_NUMBER) }</ChequeNo>
                        <ChqbnkCode>{ data($depositoChequeCajaFCY/BANK_CODE) }</ChqbnkCode>
                    </mCHEQUENUMBER>
                </gCHEQUENUMBER>
            </TELLERFICOHNDEPINTWSType>
        </ns1:DepositodechequedegerenciaFCY>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $depositoChequeCajaFCY as element(ns0:depositoChequeCajaFCY) external;
declare variable $consultadechequedegerenciaFCYResponse as element(ns1:ConsultadechequedegerenciaFCYResponse) external;

xf:DepositoChequeCajaFCYIn($autenticacionRequestHeader,
    $depositoChequeCajaFCY,
    $consultadechequedegerenciaFCYResponse)