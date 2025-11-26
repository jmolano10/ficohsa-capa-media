xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/payRemittancesTypes";
(:: import schema at "../../../../../MWBanking/Remittances/RequestorServices/XSD/payRemittancesTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/PagoFicoRemesasBS";
(:: import schema at "../../../../ProviderServices/XSD/PayRemittances/PagoFicoRemesasBS_sp.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $input as element() (:: schema-element(ns1:pagoRemesas) ::) external;
declare variable $fechaTransaccion as xs:string external;
declare variable $usuarioPago as xs:string external;
declare variable $pinRem as xs:string external;

declare function xq:pagoFicoRemesaIn($input as element() (:: schema-element(ns1:pagoRemesas) ::), 
                                     $fechaTransaccion as xs:string, 
                                     $usuarioPago as xs:string, 
                                     $pinRem as xs:string) 
                                     as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:PCLV_GIR>{fn:data($input/ns1:REMITTANCE_ID)}</ns2:PCLV_GIR>
        <ns2:PBEN_IDE>{fn:data($input/ns1:BENEFICIARY_INFO/ns1:ID)}</ns2:PBEN_IDE>
        <ns2:PSEC_TRX>{fn:data($input/ns1:REFERENCE_NUMBER)}</ns2:PSEC_TRX>
        <ns2:PCOD_USR>{fn:data($usuarioPago)}</ns2:PCOD_USR>
        <ns2:PCOD_AGE></ns2:PCOD_AGE>
        { for $OCCUPATION in $input/ns1:BENEFICIARY_INFO/ns1:OCCUPATION
          return
          <ns2:POCUPAC>{fn:data($OCCUPATION)}</ns2:POCUPAC>
        }
        { for $DATE_OF_BIRTH in $input/ns1:BENEFICIARY_INFO/ns1:DATE_OF_BIRTH
        return
          <ns2:PFEC_NAC>{fn:data($DATE_OF_BIRTH)}</ns2:PFEC_NAC>
        }
        <ns2:PFEC_NAC></ns2:PFEC_NAC>
        {
            if ($input/ns1:BENEFICIARY_INFO/ns1:PHONE_NUMBER)
            then <ns2:PTELEFONO>{fn:data($input/ns1:BENEFICIARY_INFO/ns1:PHONE_NUMBER)}</ns2:PTELEFONO>
            else ()
        }
        {
            if ($input/ns1:BENEFICIARY_INFO/ns1:ADDRESS)
            then <ns2:PDIRECCION>{fn:data($input/ns1:BENEFICIARY_INFO/ns1:ADDRESS)}</ns2:PDIRECCION>
            else ()
        }
        {
            if ($input/ns1:BENEFICIARY_INFO/ns1:STATE)
            then <ns2:PDEPTO>{fn:data($input/ns1:BENEFICIARY_INFO/ns1:STATE)}</ns2:PDEPTO>
            else ()
        }
        {
            if ($input/ns1:BENEFICIARY_INFO/ns1:CITY)
            then <ns2:PCIUDAD>{fn:data($input/ns1:BENEFICIARY_INFO/ns1:CITY)}</ns2:PCIUDAD>
            else ()
        }
        <ns2:PFEC_TRX>{fn:data($fechaTransaccion)}</ns2:PFEC_TRX>
        <ns2:PIND_REM>{fn:data($pinRem)}</ns2:PIND_REM>
    </ns2:InputParameters>
};

xq:pagoFicoRemesaIn($input, $fechaTransaccion, $usuarioPago, $pinRem)
