pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Records is ERC721 {
    mapping(uint256 => insurance) insurancelist;
    mapping(uint256 => history) patienthistory;
    mapping(uint256 => past) pasthistory;
    mapping(uint256 => diag) diagnosis;
    mapping(uint256 => treat) treatment;
    mapping(uint256 => prev) prevdates;
    mapping(uint256 => patient) patientlist;

    struct patient {
        uint256 patient_id;
    }
    patient p;
    struct prev {
        uint256 patient_id;
        string previous;
    }
    prev pr;

    struct insurance {
        uint256 patient_id;
        string applicable;
        uint64 policy_no;
        string insurer;
        string policy_type;
        string policy_limit;
    }
    insurance i;

    struct history {
        uint256 patient_id;
        string complaints;
        string duration;
    }
    history hi;
    struct past {
        uint256 patient_id;
        string family_history;
        string personal_history;
        string drug_history;
    }
    past pa;

    struct diag {
        uint256 patient_id;
        string diag_summary;
        string prescription;
    }
    diag d;
    struct treat {
        string treatment;
        string date_treatment;
        uint256 doctor_id;
        uint256 hospital_id;
        string discharge;
        string follow_up;
    }
    treat tr;
    address owner;

    constructor() public ERC721("MedicalEHR", "MEHR") {
        owner = 0x0361Edc48586e2BDDA5acFFE234960f82F839300; //metamsk wallet address
    }

    modifier isOwner() {
        require(msg.sender == owner, "Access is not allowed");

        _;
    }

    function namedecl() public view returns (string memory) {
        return name();
    }

    function symboldecl() public view returns (string memory) {
        return symbol();
    }

    function medical_record(uint256 patient_id) public {
        _mint(msg.sender, patient_id);

        patientlist[patient_id] = p;
    }

    function previous_dates(
        uint256 patient_id,
        string memory _previous
    ) public {
        pr.previous = _previous;

        prevdates[patient_id] = pr;
    }

    function get_previous_dates(
        uint256 patient_id
    ) public view returns (string memory) {
        prev memory pr = prevdates[patient_id];
        return (pr.previous);
    }

    function insurance_details(
        uint256 patient_id,
        string memory _applicable,
        uint64 _policy_no,
        string memory _insurer,
        string memory _policy_type,
        string memory _policy_limit
    ) public isOwner {
        i.applicable = _applicable;
        i.policy_no = _policy_no;
        i.insurer = _insurer;
        i.policy_type = _policy_type;
        i.policy_limit = _policy_limit;

        insurancelist[patient_id] = i;
    }

    function get_insurance(
        uint256 patient_id
    )
        public
        view
        returns (
            string memory,
            uint64,
            string memory,
            string memory,
            string memory
        )
    {
        insurance memory i = insurancelist[patient_id];
        return (
            i.applicable,
            i.policy_no,
            i.insurer,
            i.policy_type,
            i.policy_limit
        );
    }

    function present_illness(
        uint256 patient_id,
        string memory _complaints,
        string memory _duration
    ) public isOwner {
        hi.complaints = _complaints;
        hi.duration = _duration;

        patienthistory[patient_id] = hi;
    }

    function get_present_illness(
        uint256 patient_id
    ) public view returns (string memory, string memory) {
        history memory hi = patienthistory[patient_id];
        return (hi.complaints, hi.duration);
    }

    function past_illness(
        uint256 patient_id,
        string memory _family_history,
        string memory _personal_history,
        string memory _drug_history
    ) public isOwner {
        pa.family_history = _family_history;
        pa.personal_history = _personal_history;
        pa.drug_history = _drug_history;

        pasthistory[patient_id] = pa;
    }

    function get_past_illness(
        uint256 patient_id
    ) public view returns (string memory, string memory, string memory) {
        past memory pa = pasthistory[patient_id];
        return (pa.family_history, pa.personal_history, pa.drug_history);
    }

    function func_diagnosis(
        uint256 patient_id,
        string memory _diag_summary,
        string memory _prescription
    ) public isOwner {
        d.diag_summary = _diag_summary;
        d.prescription = _prescription;

        diagnosis[patient_id] = d;
    }

    function get_func_diagnosis(
        uint256 patient_id
    ) public view returns (string memory, string memory) {
        diag memory d = diagnosis[patient_id];

        return (d.diag_summary, d.prescription);
    }

    function treatment_summary(
        uint256 patient_id,
        string memory _treatment,
        string memory _date_treatment,
        uint256 _doctor_id,
        uint256 _hospital_id,
        string memory _discharge,
        string memory _follow_up
    ) public isOwner {
        tr.treatment = _treatment;
        tr.date_treatment = _date_treatment;
        tr.doctor_id = _doctor_id;
        tr.hospital_id = _hospital_id;
        tr.discharge = _discharge;
        tr.follow_up = _follow_up;

        treatment[patient_id] = tr;
    }

    function get_treatment_summary(
        uint256 patient_id
    )
        public
        view
        returns (
            string memory,
            string memory,
            uint256,
            uint256,
            string memory,
            string memory
        )
    {
        treat memory tr = treatment[patient_id];

        return (
            tr.treatment,
            tr.date_treatment,
            tr.doctor_id,
            tr.hospital_id,
            tr.discharge,
            tr.follow_up
        );
    }
}
