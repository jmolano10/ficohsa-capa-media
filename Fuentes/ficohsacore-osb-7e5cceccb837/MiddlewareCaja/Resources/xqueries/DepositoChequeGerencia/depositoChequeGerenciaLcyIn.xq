(:: pragma bea:global-element-parameter parameter="$depositoChequeGerencia" element="ns1:depositoChequeGerencia" location="../../xsds/DepositoChequeGerencia/DepositoChequeGerencia.xsd" ::)
(:: pragma bea:global-element-return element="ns0:DepositoChequeGerenciaLCY" location="../../xsds/TransaccionesAutobancos/XMLSchema_1271081668.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/depositoChequeGerencia";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoChequeGerencia/depositoChequeGerenciaLcyIn/";

declare function xf:depositoChequeGerenciaLcyIn($userName as xs:string,
    $password as xs:string,
    $uuid as xs:string,
    $depositoChequeGerencia as element(ns1:depositoChequeGerencia))
    as element(ns0:DepositoChequeGerenciaLCY) {
        <ns0:DepositoChequeGerenciaLCY>
        	<WebRequestCommon>
                <userName>{ $userName }</userName>
                <password>{ $password }</password>
            </WebRequestCommon>
            <OfsFunction>            
                <messageId>{ $uuid }</messageId>
            </OfsFunction>           
            <TELLERFICOCASHIERCHEQUEDEPType>
            <DepositAccount>{ data($depositoChequeGerencia/DEPOSIT_ACCOUNT) }</DepositAccount>
                <gNARRATIVE2>                
                    {
                        for $DESCRIPTION in $depositoChequeGerencia/DESCRIPTION
                        return
                            <Narrative>{ data($DESCRIPTION) }</Narrative>
                    }
                </gNARRATIVE2>  
                <gCHEQUENUMBER>
                    <mCHEQUENUMBER>
                        <ChequeNumber>{ data($depositoChequeGerencia/CHEQUE_NUMBER) }</ChequeNumber>
                    </mCHEQUENUMBER>
                </gCHEQUENUMBER>              
                {
                    for $DEPOSITOR_ID in $depositoChequeGerencia/DEPOSITOR_ID
                    return
                        <LRBENID>{ data($DEPOSITOR_ID) }</LRBENID>
                }
                {
                    for $DEPOSITOR_NAME in $depositoChequeGerencia/DEPOSITOR_NAME
                    return
                        <LRBENNAME>{ data($DEPOSITOR_NAME) }</LRBENNAME>
                }
                {
                    for $CHANNEL in $depositoChequeGerencia/CHANNEL
                    return
                        <LRCHANNELID>{ data($CHANNEL) }</LRCHANNELID>
                }
            </TELLERFICOCASHIERCHEQUEDEPType>
        </ns0:DepositoChequeGerenciaLCY>
};

declare variable $userName as xs:string external;
declare variable $password as xs:string external;
declare variable $uuid as xs:string external;
declare variable $depositoChequeGerencia as element(ns1:depositoChequeGerencia) external;

xf:depositoChequeGerenciaLcyIn($userName,
    $password,
    $uuid,
    $depositoChequeGerencia)