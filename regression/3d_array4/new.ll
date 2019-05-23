; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@__const.main.array = private unnamed_addr constant [2 x [2 x [2 x i32]]] [[2 x [2 x i32]] [[2 x i32] [i32 2, i32 2], [2 x i32] [i32 2, i32 2]], [2 x [2 x i32]] [[2 x i32] [i32 2, i32 2], [2 x i32] [i32 2, i32 2]]], align 16

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %array = alloca [2 x [2 x [2 x i32]]], align 16
  %product = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  %0 = bitcast [2 x [2 x [2 x i32]]]* %array to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %0, i8* align 16 bitcast ([2 x [2 x [2 x i32]]]* @__const.main.array to i8*), i64 32, i1 false)
  store i32 1, i32* %product, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %1 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %1, 2
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %j, align 4
  br label %while.cond

while.cond:                                       ; preds = %while.end, %for.body
  %2 = load i32, i32* %j, align 4
  %cmp1 = icmp slt i32 %2, 2
  br i1 %cmp1, label %while.body, label %while.end10

while.body:                                       ; preds = %while.cond
  store i32 0, i32* %k, align 4
  br label %while.cond2

while.cond2:                                      ; preds = %while.body4, %while.body
  %3 = load i32, i32* %k, align 4
  %cmp3 = icmp slt i32 %3, 2
  br i1 %cmp3, label %while.body4, label %while.end

while.body4:                                      ; preds = %while.cond2
  %4 = load i32, i32* %i, align 4
  %idxprom = sext i32 %4 to i64
  %arrayidx = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 %idxprom
  %5 = load i32, i32* %j, align 4
  %idxprom5 = sext i32 %5 to i64
  %arrayidx6 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx, i64 0, i64 %idxprom5
  %6 = load i32, i32* %k, align 4
  %idxprom7 = sext i32 %6 to i64
  %arrayidx8 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx6, i64 0, i64 %idxprom7
  %7 = load i32, i32* %arrayidx8, align 4
  %8 = load i32, i32* %product, align 4
  %mul = mul nsw i32 %7, %8
  store i32 %mul, i32* %product, align 4
  %9 = load i32, i32* %k, align 4
  %inc = add nsw i32 %9, 1
  store i32 %inc, i32* %k, align 4
  br label %while.cond2

while.end:                                        ; preds = %while.cond2
  %10 = load i32, i32* %j, align 4
  %inc9 = add nsw i32 %10, 1
  store i32 %inc9, i32* %j, align 4
  br label %while.cond

while.end10:                                      ; preds = %while.cond
  br label %for.inc

for.inc:                                          ; preds = %while.end10
  %11 = load i32, i32* %i, align 4
  %inc11 = add nsw i32 %11, 1
  store i32 %inc11, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %12 = load i32, i32* %product, align 4
  %arrayidx12 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 0
  %arrayidx13 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx12, i64 0, i64 0
  %arrayidx14 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx13, i64 0, i64 0
  %13 = load i32, i32* %arrayidx14, align 16
  %arrayidx15 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 0
  %arrayidx16 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx15, i64 0, i64 0
  %arrayidx17 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx16, i64 0, i64 0
  %14 = load i32, i32* %arrayidx17, align 16
  %mul18 = mul nsw i32 %13, %14
  %arrayidx19 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 0
  %arrayidx20 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx19, i64 0, i64 0
  %arrayidx21 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx20, i64 0, i64 0
  %15 = load i32, i32* %arrayidx21, align 16
  %mul22 = mul nsw i32 %mul18, %15
  %arrayidx23 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 0
  %arrayidx24 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx23, i64 0, i64 0
  %arrayidx25 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx24, i64 0, i64 0
  %16 = load i32, i32* %arrayidx25, align 16
  %mul26 = mul nsw i32 %mul22, %16
  %arrayidx27 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 0
  %arrayidx28 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx27, i64 0, i64 0
  %arrayidx29 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx28, i64 0, i64 0
  %17 = load i32, i32* %arrayidx29, align 16
  %mul30 = mul nsw i32 %mul26, %17
  %arrayidx31 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 0
  %arrayidx32 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx31, i64 0, i64 0
  %arrayidx33 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx32, i64 0, i64 0
  %18 = load i32, i32* %arrayidx33, align 16
  %mul34 = mul nsw i32 %mul30, %18
  %arrayidx35 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 0
  %arrayidx36 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx35, i64 0, i64 0
  %arrayidx37 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx36, i64 0, i64 0
  %19 = load i32, i32* %arrayidx37, align 16
  %mul38 = mul nsw i32 %mul34, %19
  %arrayidx39 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 0
  %arrayidx40 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx39, i64 0, i64 0
  %arrayidx41 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx40, i64 0, i64 0
  %20 = load i32, i32* %arrayidx41, align 16
  %mul42 = mul nsw i32 %mul38, %20
  %cmp43 = icmp eq i32 %12, %mul42
  %conv = zext i1 %cmp43 to i32
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv)
  %21 = load i32, i32* %retval, align 4
  ret i32 %21
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1) #1

declare dso_local i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 8.0.0 "}
