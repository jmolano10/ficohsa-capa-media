xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$scanResponse1" element="ns0:scanResponse" location="../xsd/SafewatchService_schema1.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaSafewatchResponse" location="../../ConsultaSafewatch/xsd/consultaSafewatchTypes.xsd" ::)

declare namespace ns0 = "http://service/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaSafewatchTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Safewatch/xq/ScanOut/";

declare function xf:ScanOut($scanResponse1 as element(ns0:scanResponse))
    as element(ns1:consultaSafewatchResponse) {
        <ns1:consultaSafewatchResponse>
            <SCAN>
                <VIOLATIONS>{ data($scanResponse1/return/scan/violation) }</VIOLATIONS>
                <ACCEPT>{ data($scanResponse1/return/scan/accept) }</ACCEPT>
                <EXTERNAL>{ data($scanResponse1/return/scan/external) }</EXTERNAL>
                <DETECTION_ID>{ data($scanResponse1/return/scan/detectionId) }</DETECTION_ID>
                {
                    for $gender in $scanResponse1/return/scan/gender
                    return
                        <GENDER>{ data($gender) }</GENDER>
                }
                {
                    for $statusCode in $scanResponse1/return/scan/statusCode
                    return
                        <STATUS_CODE>{ data($statusCode) }</STATUS_CODE>
                }
                {
                    for $sessionId in $scanResponse1/return/scan/sessionId
                    return
                        <SESSION_ID>{ data($sessionId) }</SESSION_ID>
                }
                {
                    for $user in $scanResponse1/return/scan/user
                    return
                        <USER>{ data($user) }</USER>
                }
                <REPORTS>
                    {
                        for $report in $scanResponse1/return/scan/reports/report
                        return
                            <REPORT>
                                {
                                    for $status in $report/status
                                    return
                                        <STATUS>{ data($status) }</STATUS>
                                }
                                {
                                    for $data in $report/data
                                    return
                                        <DATA>{ data($data) }</DATA>
                                }
                                {
                                    for $match in $report/match
                                    return
                                        <MATCH>{ data($match) }</MATCH>
                                }
                                <BIC>
                                    {
                                        for $scanned in $report/bic/scanned
                                        return
                                            <SCANNED>{ data($scanned) }</SCANNED>
                                    }
                                    {
                                        for $address in $report/bic/address
                                        return
                                            <ADDRESS>{ data($address) }</ADDRESS>
                                    }
                                    {
                                        for $city in $report/bic/city
                                        return
                                            <CITY>{ data($city) }</CITY>
                                    }
                                    {
                                        for $country in $report/bic/country
                                        return
                                            <COUNTRY>{ data($country) }</COUNTRY>
                                    }
                                </BIC>
                                <RANK>{ data($report/rank) }</RANK>
                                {
                                    for $listName in $report/listName
                                    return
                                        <LIST_NAME>{ data($listName) }</LIST_NAME>
                                }
                                {
                                    for $listDate in $report/listDate
                                    return
                                        <LIST_DATE>{ data($listDate) }</LIST_DATE>
                                }
                                {
                                    for $entityId in $report/entityId
                                    return
                                        <ENTITY_ID>{ data($entityId) }</ENTITY_ID>
                                }
                                {
                                    for $category in $report/category
                                    return
                                        <CATEGORY>{ data($category) }</CATEGORY>
                                }
                                {
                                    for $remark in $report/remark
                                    return
                                        <REMARK>{ data($remark) }</REMARK>
                                }
                                {
                                    for $title in $report/title
                                    return
                                        <TITLE>{ data($title) }</TITLE>
                                }
                                <POSITION>
                                    {
                                        for $begin in $report/position/begin
                                        return
                                            <BEGIN>{ data($begin) }</BEGIN>
                                    }
                                    {
                                        for $end in $report/position/end
                                        return
                                            <END>{ data($end) }</END>
                                    }
                                </POSITION>
                                {
                                    for $field in $report/field
                                    return
                                        <FIELD>{ data($field) }</FIELD>
                                }
                                {
                                    for $line in $report/line
                                    return
                                        <LINE>{ data($line) }</LINE>
                                }
                                {
                                    for $program in $report/program
                                    return
                                        <PROGRAM>{ data($program) }</PROGRAM>
                                }
                                <DATE_OF_BIRTH>{ data($report/dateOfBirth) }</DATE_OF_BIRTH>
                                {
                                    for $placeOfBirth in $report/placeOfBirth
                                    return
                                        <PLACE_OF_BIRTH>{ data($placeOfBirth) }</PLACE_OF_BIRTH>
                                }
                                {
                                    for $externalId in $report/externalId
                                    return
                                        <EXTERNAL_ID>{ data($externalId) }</EXTERNAL_ID>
                                }
                                <ENTITIES>
                                    {
                                        for $entity in $report/entities/entity
                                        return
                                            <ENTITY>
                                                {
                                                    for $name in $entity/name
                                                    return
                                                        <NAME>{ data($name) }</NAME>
                                                }
                                                {
                                                    for $type in $entity/type
                                                    return
                                                        <TYPE>{ data($type) }</TYPE>
                                                }
                                            </ENTITY>
                                    }
                                </ENTITIES>
                                <ENTITIES_ADDRESS>
                                    {
                                        for $address in $report/entitiesAddress/address
                                        return
                                            <ADDRESS>
                                                {
                                                    for $address0 in $address/address
                                                    return
                                                        <ADDRESS>{ data($address0) }</ADDRESS>
                                                }
                                                {
                                                    for $city in $address/city
                                                    return
                                                        <CITY>{ data($city) }</CITY>
                                                }
                                                {
                                                    for $country in $address/country
                                                    return
                                                        <COUNTRY>{ data($country) }</COUNTRY>
                                                }
                                            </ADDRESS>
                                    }
                                </ENTITIES_ADDRESS>
                            </REPORT>
                    }
                </REPORTS>
            </SCAN>
        </ns1:consultaSafewatchResponse>
};

declare variable $scanResponse1 as element(ns0:scanResponse) external;

xf:ScanOut($scanResponse1)