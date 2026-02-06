xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$bulkProvisionStartJob" element="ns0:BulkProvisionStartJob" location="../../DigitalizacionTarjetas/xsd/digitalizacionTarjetasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:BulkProvisionStartJob" location="../../../BusinessServices/BulkProvisionStartJob/xsd/bulkProvisionStartJobTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/bulkProvisionStartJobTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/digitalizacionTarjetasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/BulkProvisionStartJob/xq/bulkProvisionStartJobOICIn/";

declare function xf:bulkProvisionStartJobOICIn($bulkProvisionStartJob as element(ns0:BulkProvisionStartJob))
    as element(ns1:BulkProvisionStartJob) {
        <ns1:BulkProvisionStartJob>
            <REQUEST_ID>{ data($bulkProvisionStartJob/REQUEST_ID) }</REQUEST_ID>
            <INSTITUTION_CODE>{ data($bulkProvisionStartJob/INSTITUTION_CODE) }</INSTITUTION_CODE>
            <VAULT_IDENTIFICATION>{ data($bulkProvisionStartJob/VAULT_IDENTIFICATION) }</VAULT_IDENTIFICATION>
            <ENCRYPTED_CARD_INFO_LIST>
                {
                    for $ENCRYPTED_CARD_INFO in $bulkProvisionStartJob/ENCRYPTED_CARD_INFO_LIST/ENCRYPTED_CARD_INFO
                    return
                        <ENCRYPTED_CARD_INFO>
                            <ALGORITHM>{ data($ENCRYPTED_CARD_INFO/ALGORITHM) }</ALGORITHM>
                            {
                                for $NONCE in $ENCRYPTED_CARD_INFO/NONCE
                                return
                                    <NONCE>{ data($NONCE) }</NONCE>
                            }
                            {
                                for $IV in $ENCRYPTED_CARD_INFO/IV
                                return
                                    <IV>{ data($IV) }</IV>
                            }
                            <ENCRYPTED_DATA>{ data($ENCRYPTED_CARD_INFO/ENCRYPTED_DATA) }</ENCRYPTED_DATA>
                            {
                                for $ASSOCIATED_DATA in $ENCRYPTED_CARD_INFO/ASSOCIATED_DATA
                                return
                                    <ASSOCIATED_DATA>{ data($ASSOCIATED_DATA) }</ASSOCIATED_DATA>
                            }
                            <MAC_LENGTH>{ data($ENCRYPTED_CARD_INFO/MAC_LENGTH) }</MAC_LENGTH>
                        </ENCRYPTED_CARD_INFO>
                }
            </ENCRYPTED_CARD_INFO_LIST>
        </ns1:BulkProvisionStartJob>
};

declare variable $bulkProvisionStartJob as element(ns0:BulkProvisionStartJob) external;

xf:bulkProvisionStartJobOICIn($bulkProvisionStartJob)