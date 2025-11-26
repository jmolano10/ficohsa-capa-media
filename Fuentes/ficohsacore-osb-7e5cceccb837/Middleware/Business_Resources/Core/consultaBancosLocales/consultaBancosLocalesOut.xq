(:: pragma bea:global-element-parameter parameter="$consultadebancoslocalesResponse1" element="ns0:ConsultadebancoslocalesResponse" location="../Resources/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaBancosLocalesResponse" location="consultaBancosLocalesTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaBancosLocalesTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/consultaBancosLocales/consultaBancosLocalesOut/";

declare function xf:consultaBancosLocalesOut($consultadebancoslocalesResponse1 as element(ns0:ConsultadebancoslocalesResponse))
    as element(ns1:consultaBancosLocalesResponse) {
        <ns1:consultaBancosLocalesResponse>
            {
                for $gWSLOCALBANKSDetailType in $consultadebancoslocalesResponse1/WSLOCALBANKSType[1]/gWSLOCALBANKSDetailType
                return
                    <ns1:consultaBancosLocalesResponseType>
                        {
                            for $mWSLOCALBANKSDetailType in $gWSLOCALBANKSDetailType/mWSLOCALBANKSDetailType
                            return
                                <ns1:consultaBancosLocalesResponseRecordType>
                                    {
                                        for $ID in $mWSLOCALBANKSDetailType/ID
                                        return
                                            <BANK_ID>{ data($ID) }</BANK_ID>
                                    }
                                    {
                                        for $BANKNAME in $mWSLOCALBANKSDetailType/BANKNAME
                                        return
                                            <BANK_NAME>{ data($BANKNAME) }</BANK_NAME>
                                    }
                                </ns1:consultaBancosLocalesResponseRecordType>
                        }
                    </ns1:consultaBancosLocalesResponseType>
            }
        </ns1:consultaBancosLocalesResponse>
};

declare variable $consultadebancoslocalesResponse1 as element(ns0:ConsultadebancoslocalesResponse) external;

xf:consultaBancosLocalesOut($consultadebancoslocalesResponse1)