Require Import Coq.ZArith.ZArith.
Require Import Crypto.Language.
Require Import Crypto.LanguageWf.
Require Import Crypto.RewriterAllTacticsExtra.
Require Import Crypto.RewriterRulesProofs.

Module Compilers.
  Import Language.Compilers.
  Import LanguageWf.Compilers.
  Import RewriterAllTactics.Compilers.RewriteRules.GoalType.
  Import RewriterAllTacticsExtra.Compilers.RewriteRules.Tactic.
  Import Compilers.Classes.

  Module Import RewriteRules.
    Section __.
      Context (max_const_val : Z).

      Definition VerifiedRewriterArith : VerifiedRewriter.
      Proof using All. make_rewriter false (arith_rewrite_rules_proofs max_const_val). Defined.

      Definition RewriteArith {t} := Eval hnf in @Rewrite VerifiedRewriterArith t.

      Lemma Wf_RewriteArith {t} e (Hwf : Wf e) : Wf (@RewriteArith t e).
      Proof. now apply VerifiedRewriterArith. Qed.

      Lemma Interp_gen_RewriteArith {cast_outside_of_range t} e (Hwf : Wf e)
        : expr.Interp (@ident_gen_interp _ cast_outside_of_range) (@RewriteArith t e)
          == expr.Interp (@ident_gen_interp _ cast_outside_of_range) e.
      Proof. now apply VerifiedRewriterArith. Qed.

      Lemma Interp_RewriteArith {t} e (Hwf : Wf e) : expr.Interp (@ident_interp _) (@RewriteArith t e) == expr.Interp (@ident_interp _) e.
      Proof. apply Interp_gen_RewriteArith; assumption. Qed.
    End __.
  End RewriteRules.

  Module Export Hints.
    Hint Resolve Wf_RewriteArith : wf.
    Hint Rewrite @Interp_gen_RewriteArith @Interp_RewriteArith : interp.
  End Hints.
End Compilers.
