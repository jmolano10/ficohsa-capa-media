(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoChequeCajaFCY" element="ns1:pagoChequeCajaFCY" location="../../xsds/PagoChequeCajaFCY/PagoChequeCajaFCY.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadechequedegerenciaFCYResponse" element="ns0:ConsultadechequedegerenciaFCYResponse" location="../../xsds/ChequeGerencia/XMLSchema_-1805424041.xsd" ::)
(:: pragma bea:global-element-return element="ns0:PagodechequedegerenciaFCY" location="../../xsds/RetirosYPagos/XMLSchema_1006378181.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoChequeCajaFCYTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoChequeCajaFCY/PagoChequeCajaFCYIn/";

declare function xf:PagoChequeCajaFCYIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $pagoChequeCajaFCY as element(ns1:pagoChequeCajaFCY),
    $consultadechequedegerenciaFCYResponse as element(ns0:ConsultadechequedegerenciaFCYResponse))
    as element(ns0:PagodechequedegerenciaFCY) {
        <ns0:PagodechequedegerenciaFCY>
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
            <TELLERFICOHNCASHINTWSType>
                <CURRENCY1>{ data($pagoChequeCajaFCY/CHECK_CURRENCY) }</CURRENCY1>
                <gACCOUNT1>
                    <mACCOUNT1>
                        {
                            for $Nostro in $consultadechequedegerenciaFCYResponse/FICOHNFCYDRAFTDETAILSWSType[1]/gFICOHNFCYDRAFTDETAILSWSDetailType/mFICOHNFCYDRAFTDETAILSWSDetailType[1]/Nostro
                            return
                                <ACCOUNT>{ data($Nostro) }</ACCOUNT>
                        }
                        <AMOUNTFCY1>{ data($pagoChequeCajaFCY/CHECK_AMOUNT) }</AMOUNTFCY1>
                    </mACCOUNT1>
                </gACCOUNT1>
                <gCHEQUENUMBER>
                    <mCHEQUENUMBER>
                        <CHEQUENO>{ data($pagoChequeCajaFCY/CHECK_NUMBER) }</CHEQUENO>
                        <CHQBNKCODE>{ data($pagoChequeCajaFCY/BANK_CODE) }</CHQBNKCODE>
                    </mCHEQUENUMBER>
                </gCHEQUENUMBER>
            </TELLERFICOHNCASHINTWSType>
        </ns0:PagodechequedegerenciaFCY>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoChequeCajaFCY as element(ns1:pagoChequeCajaFCY) external;
declare variable $consultadechequedegerenciaFCYResponse as element(ns0:ConsultadechequedegerenciaFCYResponse) external;

xf:PagoChequeCajaFCYIn($autenticacionRequestHeader,
    $pagoChequeCajaFCY,
    $consultadechequedegerenciaFCYResponse)