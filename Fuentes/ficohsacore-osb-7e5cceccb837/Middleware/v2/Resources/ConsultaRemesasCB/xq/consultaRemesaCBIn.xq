(:: pragma bea:global-element-parameter parameter="$consultaRemesas" element="ns1:consultaRemesas" location="../xsd/consultaRemesasCBTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaRemesas" location="../../ConsultaRemesas/xsd/consultaRemesasTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesasCBTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesasCB/xq/consultaRemesaCBIn/";

declare function xf:consultaRemesaCBIn($consultaRemesas as element(ns1:consultaRemesas))
    as element(ns0:consultaRemesas) {
        <ns0:consultaRemesas>
            {
                for $REMITTANCE_ID in $consultaRemesas/REMITTANCE_ID
                return
                    <REMITTANCE_ID>{ data($REMITTANCE_ID) }</REMITTANCE_ID>
            }
            {
                for $REMITTER_FIRSTNAME in $consultaRemesas/REMITTER_FIRSTNAME
                return
                    <REMITTER_FIRSTNAME>{ data($REMITTER_FIRSTNAME) }</REMITTER_FIRSTNAME>
            }
            {
                for $REMITTER_MIDDLENAME in $consultaRemesas/REMITTER_MIDDLENAME
                return
                    <REMITTER_MIDDLENAME>{ data($REMITTER_MIDDLENAME) }</REMITTER_MIDDLENAME>
            }
            {
                for $REMITTER_FIRSTSURNAME in $consultaRemesas/REMITTER_FIRSTSURNAME
                return
                    <REMITTER_FIRSTSURNAME>{ data($REMITTER_FIRSTSURNAME) }</REMITTER_FIRSTSURNAME>
            }
            {
                for $REMITTER_SECONDSURNAME in $consultaRemesas/REMITTER_SECONDSURNAME
                return
                    <REMITTER_SECONDSURNAME>{ data($REMITTER_SECONDSURNAME) }</REMITTER_SECONDSURNAME>
            }
            {
                for $BENEFICIARY_FIRSTNAME in $consultaRemesas/BENEFICIARY_FIRSTNAME
                return
                    <BENEFICIARY_FIRSTNAME>{ data($BENEFICIARY_FIRSTNAME) }</BENEFICIARY_FIRSTNAME>
            }
            {
                for $BENEFICIARY_MIDDLENAME in $consultaRemesas/BENEFICIARY_MIDDLENAME
                return
                    <BENEFICIARY_MIDDLENAME>{ data($BENEFICIARY_MIDDLENAME) }</BENEFICIARY_MIDDLENAME>
            }
            {
                for $BENEFICIARY_FIRSTSURNAME in $consultaRemesas/BENEFICIARY_FIRSTSURNAME
                return
                    <BENEFICIARY_FIRSTSURNAME>{ data($BENEFICIARY_FIRSTSURNAME) }</BENEFICIARY_FIRSTSURNAME>
            }
            {
                for $BENEFICIARY_SECONDSURNAME in $consultaRemesas/BENEFICIARY_SECONDSURNAME
                return
                    <BENEFICIARY_SECONDSURNAME>{ data($BENEFICIARY_SECONDSURNAME) }</BENEFICIARY_SECONDSURNAME>
            }
            {
                for $CORRESPONSAL_BRANCHCODE in $consultaRemesas/CORRESPONSAL_BRANCHCODE
                return
                    <CORRESPONSAL_BRANCHCODE>{ data($CORRESPONSAL_BRANCHCODE) }</CORRESPONSAL_BRANCHCODE>
            }
            <ADDITIONAL_INFO>
                {
                    for $INFO in $consultaRemesas/ADDITIONAL_INFO/INFO
                    return
                        <INFO>
                            {
                                for $NAME in $INFO/NAME
                                return
                                    <NAME>{ data($NAME) }</NAME>
                            }
                            {
                                for $VALUE in $INFO/VALUE
                                return
                                    <VALUE>{ data($VALUE) }</VALUE>
                            }
                        </INFO>
                }
            </ADDITIONAL_INFO>
            
        </ns0:consultaRemesas>
};

declare variable $consultaRemesas as element(ns1:consultaRemesas) external;

xf:consultaRemesaCBIn($consultaRemesas)
