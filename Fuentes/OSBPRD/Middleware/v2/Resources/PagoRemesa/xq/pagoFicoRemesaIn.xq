(:: pragma bea:global-element-parameter parameter="$pagoRemesas1" element="ns0:pagoRemesas" location="../xsd/pagoRemesas.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/pagoFicoRemesa/xsd/pagoFicoRemesas_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/pagoFicoRemesas";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRemesa/xq/pagoFicoRemesaIn/";

declare function xf:pagoFicoRemesaIn($pagoRemesas1 as element(ns0:pagoRemesas),
    $fechaTransaccion as xs:string,
    $usuarioPago as xs:string,
    $pinRem as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PCLV_GIR>{ data($pagoRemesas1/REMITTANCE_ID) }</ns1:PCLV_GIR>
            <ns1:PBEN_IDE>{ data($pagoRemesas1/BENEFICIARY_INFO/ID) }</ns1:PBEN_IDE>
            <ns1:PSEC_TRX>{ data($pagoRemesas1/REFERENCE_NUMBER) }</ns1:PSEC_TRX>
            <ns1:PCOD_USR>{ $usuarioPago }</ns1:PCOD_USR>
            <ns1:PCOD_AGE>{ data($pagoRemesas1/PAYER_CODE) }</ns1:PCOD_AGE>
            {
                for $OCCUPATION in $pagoRemesas1/BENEFICIARY_INFO/OCCUPATION
                return
                    <ns1:POCUPAC>{ data($OCCUPATION) }</ns1:POCUPAC>
            }
            {
                for $DATE_OF_BIRTH in $pagoRemesas1/BENEFICIARY_INFO/DATE_OF_BIRTH
                return
                    <ns1:PFEC_NAC>{ data($DATE_OF_BIRTH) }</ns1:PFEC_NAC>
            }
            <ns1:PTELEFONO>{ data($pagoRemesas1/BENEFICIARY_INFO/PHONE_NUMBER) }</ns1:PTELEFONO>
            <ns1:PDIRECCION>{ data($pagoRemesas1/BENEFICIARY_INFO/ADDRESS) }</ns1:PDIRECCION>
            <ns1:PDEPTO>{ data($pagoRemesas1/BENEFICIARY_INFO/STATE) }</ns1:PDEPTO>
            <ns1:PCIUDAD>{ data($pagoRemesas1/BENEFICIARY_INFO/CITY) }</ns1:PCIUDAD>
            <ns1:PFEC_TRX>{ $fechaTransaccion }</ns1:PFEC_TRX>
            <ns1:PIND_REM>{ $pinRem }</ns1:PIND_REM>
        </ns1:InputParameters>
};

declare variable $pagoRemesas1 as element(ns0:pagoRemesas) external;
declare variable $fechaTransaccion as xs:string external;
declare variable $usuarioPago as xs:string external;
declare variable $pinRem as xs:string external;

xf:pagoFicoRemesaIn($pagoRemesas1,
    $fechaTransaccion,
    $usuarioPago,
    $pinRem)