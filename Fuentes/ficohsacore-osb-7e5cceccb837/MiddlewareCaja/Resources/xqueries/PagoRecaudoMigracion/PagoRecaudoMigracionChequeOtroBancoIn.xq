(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns3:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudoMigracion" element="ns2:pagoRecaudoMigracion" location="../../xsds/PagoRecaudoMigracion/PagoRecaudoMigracion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../xsds/Recaudos/ConsultarRelacionOperacionRecaudoMigracion/FLINK_OSB_CON_OPER_RECAUDO_MIGRACION.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Pagorecaudomigracionchqob" location="../../xsds/PagoRecaudosMigracion/XMLSchema_-1578743007.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoMigracionTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_CON_OPER_RECAUDO_MIGRACION/";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudoMigracion/PagoRecaudoMigracionChequeOtroBancoIn/";

declare function xf:PagoRecaudoMigracionChequeOtroBancoIn($autenticacionRequestHeader as element(ns3:AutenticacionRequestHeader),
    $pagoRecaudoMigracion as element(ns2:pagoRecaudoMigracion),
    $outputParameters as element(ns1:OutputParameters),
    $uuid as xs:string)
    as element(ns0:Pagorecaudomigracionchqob) {
        <ns0:Pagorecaudomigracionchqob>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl/>
                <messageId>{ $uuid }</messageId>
                <noOfAuth/>
                <replace/>
            </OfsFunction>
            <TELLERLATAMOBCHEQUEPPRTWSType>
                <PAYEECCY>{ data($pagoRecaudoMigracion/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</PAYEECCY>
                {
                    for $PAYMENT_AMOUNT in $pagoRecaudoMigracion/PAYMENT_INFORMATION/PAYMENT_AMOUNT
                    return
                        <AMOUNTLOCAL>{ data($PAYMENT_AMOUNT) }</AMOUNTLOCAL>
                }
                <gCHEQUENUMBER>
                    <mCHEQUENUMBER>
                        {
                            for $CHEQUE_NUMBER in $pagoRecaudoMigracion/PAYMENT_INFORMATION/CHEQUE_NUMBER
                            return
                                <CHEQUENO>{ data($CHEQUE_NUMBER) }</CHEQUENO>
                        }
                        {
                            for $BANK_CODE in $pagoRecaudoMigracion/PAYMENT_INFORMATION/BANK_CODE
                            return
                                <BANKSORTCODE>{ data($BANK_CODE) }</BANKSORTCODE>
                        }
                        {
                            for $DEBIT_ACCOUNT in $pagoRecaudoMigracion/PAYMENT_INFORMATION/DEBIT_ACCOUNT
                            return
                                <CHEQUEACCTNO>{ data($DEBIT_ACCOUNT) }</CHEQUEACCTNO>
                        }
                    </mCHEQUENUMBER>
                </gCHEQUENUMBER>
                <LRAGCLIENTID>{ data($pagoRecaudoMigracion/CONTRACT_ID) }</LRAGCLIENTID>
                <LRPPORTVAL>{ data($pagoRecaudoMigracion/PASSPORT_DURATION) }</LRPPORTVAL>
                <LRPPORTPLACE>{ data($pagoRecaudoMigracion/REQUEST_CITY) }</LRPPORTPLACE>
                {
                    for $NUMERO_CITA in $outputParameters/ns1:NUMERO_CITA
                    return
                        <LRAPPOINTNO>{ data($NUMERO_CITA) }</LRAPPOINTNO>
                }
                {
                    for $FECHA_CITA in $outputParameters/ns1:FECHA_CITA
                    return
                        <LRAPPOINTDT>{ data($FECHA_CITA) }</LRAPPOINTDT>
                }
                {
                    for $VALOR_CITA_FCY in $outputParameters/ns1:VALOR_CITA_FCY
                    return
                        <LRAPPOINTCHG>{ data($VALOR_CITA_FCY) }</LRAPPOINTCHG>
                }
                {
                    for $HORA_CITA in $outputParameters/ns1:HORA_CITA
                    return
                        <LRAPPOINTTIME>{ data($HORA_CITA) }</LRAPPOINTTIME>
                }
                <LRORDPARID>{ data($pagoRecaudoMigracion/REQUEST_TYPE) }</LRORDPARID>
                <LRORDNAME>{ data($pagoRecaudoMigracion/ORD_PARTY_NAME) }</LRORDNAME>
                <LRIDNUMBER>{ data($pagoRecaudoMigracion/ORD_PARTY_ID) }</LRIDNUMBER>
                {
                    for $NO_CONFIRMACION in $outputParameters/ns1:NO_CONFIRMACION
                    return
                        <LRFLINKCNFNO>{ data($NO_CONFIRMACION) }</LRFLINKCNFNO>
                }
            </TELLERLATAMOBCHEQUEPPRTWSType>
        </ns0:Pagorecaudomigracionchqob>
};

declare variable $autenticacionRequestHeader as element(ns3:AutenticacionRequestHeader) external;
declare variable $pagoRecaudoMigracion as element(ns2:pagoRecaudoMigracion) external;
declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $uuid as xs:string external;

xf:PagoRecaudoMigracionChequeOtroBancoIn($autenticacionRequestHeader,
    $pagoRecaudoMigracion,
    $outputParameters,
    $uuid)