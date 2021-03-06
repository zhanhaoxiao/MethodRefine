The files in this directory consist of those that should be necessary to reproduce the Satellite domain results published in "HTN-Maker: Learning HTNs with Minimal Additional Knowledge Engineering Required" by Chad Hogg, Hector Munoz-Avila, and Ugur Kuter published in Proceedings of the Twenty-Third AAAI Conference on Artificial Intelligence (AAAI-08).

The individual files are as follows:

`domain_strips.pddl` - A classical representation of the Satellite domain, formatted for use by HTN-Maker and related programs.

`domain_ff.pddl` - A classical representation of the Satellite domain, formatted for use with the FastForward planner.

`tasks.pddl` - A set of annotated tasks for the Satellite domain, formatted for use by HTN-Maker and related programs.

`domain_empty.htn` - An HTN representation of the Satellite domain but without any non-trivial methods, formatted for use by HTN-Maker and related programs.

`raw_probs/*.raw_prob` - A set of 100 classical planning problems in the Satellite domain, formatted for use by the FastForward planner.

`htn_probs/*.htn_prob` - A set of 100 HTN planning problems, each of which is the equivalent of its corresponding file in `raw_probs/`.

`results/trial*/training_order.txt` - A list of 75 problem numbers.

`results/trial*/current_domain.htn` - An HTN representation of the Satellite domain with methods learned from each of the problems listed in `results/trial*/training_order.txt` in order.

The intermediary results after processing each problem were not retained.
