; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %arr1 = alloca [2 x [3 x [4 x i32]]], align 16
  %arr2 = alloca [2 x [3 x [4 x i32]]], align 16
  %x = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  %arr3 = alloca [2 x [3 x [4 x i32]]], align 16
  %i24 = alloca i32, align 4
  %j28 = alloca i32, align 4
  %k32 = alloca i32, align 4
  %i63 = alloca i32, align 4
  %j67 = alloca i32, align 4
  %k71 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata [2 x [3 x [4 x i32]]]* %arr1, metadata !11, metadata !DIExpression()), !dbg !17
  call void @llvm.dbg.declare(metadata [2 x [3 x [4 x i32]]]* %arr2, metadata !18, metadata !DIExpression()), !dbg !19
  call void @llvm.dbg.declare(metadata i32* %x, metadata !20, metadata !DIExpression()), !dbg !21
  store i32 1, i32* %x, align 4, !dbg !21
  call void @llvm.dbg.declare(metadata i32* %i, metadata !22, metadata !DIExpression()), !dbg !24
  store i32 0, i32* %i, align 4, !dbg !24
  br label %for.cond, !dbg !25

for.cond:                                         ; preds = %for.inc21, %entry
  %0 = load i32, i32* %i, align 4, !dbg !26
  %cmp = icmp slt i32 %0, 2, !dbg !28
  br i1 %cmp, label %for.body, label %for.end23, !dbg !29

for.body:                                         ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i32* %j, metadata !30, metadata !DIExpression()), !dbg !33
  store i32 0, i32* %j, align 4, !dbg !33
  br label %for.cond1, !dbg !34

for.cond1:                                        ; preds = %for.inc18, %for.body
  %1 = load i32, i32* %j, align 4, !dbg !35
  %cmp2 = icmp slt i32 %1, 3, !dbg !37
  br i1 %cmp2, label %for.body3, label %for.end20, !dbg !38

for.body3:                                        ; preds = %for.cond1
  call void @llvm.dbg.declare(metadata i32* %k, metadata !39, metadata !DIExpression()), !dbg !42
  store i32 0, i32* %k, align 4, !dbg !42
  br label %for.cond4, !dbg !43

for.cond4:                                        ; preds = %for.inc, %for.body3
  %2 = load i32, i32* %k, align 4, !dbg !44
  %cmp5 = icmp slt i32 %2, 4, !dbg !46
  br i1 %cmp5, label %for.body6, label %for.end, !dbg !47

for.body6:                                        ; preds = %for.cond4
  %3 = load i32, i32* %x, align 4, !dbg !48
  %4 = load i32, i32* %i, align 4, !dbg !50
  %idxprom = sext i32 %4 to i64, !dbg !51
  %arrayidx = getelementptr inbounds [2 x [3 x [4 x i32]]], [2 x [3 x [4 x i32]]]* %arr1, i64 0, i64 %idxprom, !dbg !51
  %5 = load i32, i32* %j, align 4, !dbg !52
  %idxprom7 = sext i32 %5 to i64, !dbg !51
  %arrayidx8 = getelementptr inbounds [3 x [4 x i32]], [3 x [4 x i32]]* %arrayidx, i64 0, i64 %idxprom7, !dbg !51
  %6 = load i32, i32* %k, align 4, !dbg !53
  %idxprom9 = sext i32 %6 to i64, !dbg !51
  %arrayidx10 = getelementptr inbounds [4 x i32], [4 x i32]* %arrayidx8, i64 0, i64 %idxprom9, !dbg !51
  store i32 %3, i32* %arrayidx10, align 4, !dbg !54
  %7 = load i32, i32* %x, align 4, !dbg !55
  %8 = load i32, i32* %i, align 4, !dbg !56
  %idxprom11 = sext i32 %8 to i64, !dbg !57
  %arrayidx12 = getelementptr inbounds [2 x [3 x [4 x i32]]], [2 x [3 x [4 x i32]]]* %arr2, i64 0, i64 %idxprom11, !dbg !57
  %9 = load i32, i32* %j, align 4, !dbg !58
  %idxprom13 = sext i32 %9 to i64, !dbg !57
  %arrayidx14 = getelementptr inbounds [3 x [4 x i32]], [3 x [4 x i32]]* %arrayidx12, i64 0, i64 %idxprom13, !dbg !57
  %10 = load i32, i32* %k, align 4, !dbg !59
  %idxprom15 = sext i32 %10 to i64, !dbg !57
  %arrayidx16 = getelementptr inbounds [4 x i32], [4 x i32]* %arrayidx14, i64 0, i64 %idxprom15, !dbg !57
  store i32 %7, i32* %arrayidx16, align 4, !dbg !60
  %11 = load i32, i32* %x, align 4, !dbg !61
  %inc = add nsw i32 %11, 1, !dbg !61
  store i32 %inc, i32* %x, align 4, !dbg !61
  br label %for.inc, !dbg !62

for.inc:                                          ; preds = %for.body6
  %12 = load i32, i32* %k, align 4, !dbg !63
  %inc17 = add nsw i32 %12, 1, !dbg !63
  store i32 %inc17, i32* %k, align 4, !dbg !63
  br label %for.cond4, !dbg !64, !llvm.loop !65

for.end:                                          ; preds = %for.cond4
  br label %for.inc18, !dbg !67

for.inc18:                                        ; preds = %for.end
  %13 = load i32, i32* %j, align 4, !dbg !68
  %inc19 = add nsw i32 %13, 1, !dbg !68
  store i32 %inc19, i32* %j, align 4, !dbg !68
  br label %for.cond1, !dbg !69, !llvm.loop !70

for.end20:                                        ; preds = %for.cond1
  br label %for.inc21, !dbg !72

for.inc21:                                        ; preds = %for.end20
  %14 = load i32, i32* %i, align 4, !dbg !73
  %inc22 = add nsw i32 %14, 1, !dbg !73
  store i32 %inc22, i32* %i, align 4, !dbg !73
  br label %for.cond, !dbg !74, !llvm.loop !75

for.end23:                                        ; preds = %for.cond
  call void @llvm.dbg.declare(metadata [2 x [3 x [4 x i32]]]* %arr3, metadata !77, metadata !DIExpression()), !dbg !78
  call void @llvm.dbg.declare(metadata i32* %i24, metadata !79, metadata !DIExpression()), !dbg !81
  store i32 0, i32* %i24, align 4, !dbg !81
  br label %for.cond25, !dbg !82

for.cond25:                                       ; preds = %for.inc60, %for.end23
  %15 = load i32, i32* %i24, align 4, !dbg !83
  %cmp26 = icmp slt i32 %15, 2, !dbg !85
  br i1 %cmp26, label %for.body27, label %for.end62, !dbg !86

for.body27:                                       ; preds = %for.cond25
  call void @llvm.dbg.declare(metadata i32* %j28, metadata !87, metadata !DIExpression()), !dbg !90
  store i32 0, i32* %j28, align 4, !dbg !90
  br label %for.cond29, !dbg !91

for.cond29:                                       ; preds = %for.inc57, %for.body27
  %16 = load i32, i32* %j28, align 4, !dbg !92
  %cmp30 = icmp slt i32 %16, 3, !dbg !94
  br i1 %cmp30, label %for.body31, label %for.end59, !dbg !95

for.body31:                                       ; preds = %for.cond29
  call void @llvm.dbg.declare(metadata i32* %k32, metadata !96, metadata !DIExpression()), !dbg !99
  store i32 0, i32* %k32, align 4, !dbg !99
  br label %for.cond33, !dbg !100

for.cond33:                                       ; preds = %for.inc54, %for.body31
  %17 = load i32, i32* %k32, align 4, !dbg !101
  %cmp34 = icmp slt i32 %17, 4, !dbg !103
  br i1 %cmp34, label %for.body35, label %for.end56, !dbg !104

for.body35:                                       ; preds = %for.cond33
  %18 = load i32, i32* %i24, align 4, !dbg !105
  %idxprom36 = sext i32 %18 to i64, !dbg !107
  %arrayidx37 = getelementptr inbounds [2 x [3 x [4 x i32]]], [2 x [3 x [4 x i32]]]* %arr1, i64 0, i64 %idxprom36, !dbg !107
  %19 = load i32, i32* %j28, align 4, !dbg !108
  %idxprom38 = sext i32 %19 to i64, !dbg !107
  %arrayidx39 = getelementptr inbounds [3 x [4 x i32]], [3 x [4 x i32]]* %arrayidx37, i64 0, i64 %idxprom38, !dbg !107
  %20 = load i32, i32* %k32, align 4, !dbg !109
  %idxprom40 = sext i32 %20 to i64, !dbg !107
  %arrayidx41 = getelementptr inbounds [4 x i32], [4 x i32]* %arrayidx39, i64 0, i64 %idxprom40, !dbg !107
  %21 = load i32, i32* %arrayidx41, align 4, !dbg !107
  %22 = load i32, i32* %i24, align 4, !dbg !110
  %idxprom42 = sext i32 %22 to i64, !dbg !111
  %arrayidx43 = getelementptr inbounds [2 x [3 x [4 x i32]]], [2 x [3 x [4 x i32]]]* %arr2, i64 0, i64 %idxprom42, !dbg !111
  %23 = load i32, i32* %j28, align 4, !dbg !112
  %idxprom44 = sext i32 %23 to i64, !dbg !111
  %arrayidx45 = getelementptr inbounds [3 x [4 x i32]], [3 x [4 x i32]]* %arrayidx43, i64 0, i64 %idxprom44, !dbg !111
  %24 = load i32, i32* %k32, align 4, !dbg !113
  %idxprom46 = sext i32 %24 to i64, !dbg !111
  %arrayidx47 = getelementptr inbounds [4 x i32], [4 x i32]* %arrayidx45, i64 0, i64 %idxprom46, !dbg !111
  %25 = load i32, i32* %arrayidx47, align 4, !dbg !111
  %add = add nsw i32 %21, %25, !dbg !114
  %26 = load i32, i32* %i24, align 4, !dbg !115
  %idxprom48 = sext i32 %26 to i64, !dbg !116
  %arrayidx49 = getelementptr inbounds [2 x [3 x [4 x i32]]], [2 x [3 x [4 x i32]]]* %arr3, i64 0, i64 %idxprom48, !dbg !116
  %27 = load i32, i32* %j28, align 4, !dbg !117
  %idxprom50 = sext i32 %27 to i64, !dbg !116
  %arrayidx51 = getelementptr inbounds [3 x [4 x i32]], [3 x [4 x i32]]* %arrayidx49, i64 0, i64 %idxprom50, !dbg !116
  %28 = load i32, i32* %k32, align 4, !dbg !118
  %idxprom52 = sext i32 %28 to i64, !dbg !116
  %arrayidx53 = getelementptr inbounds [4 x i32], [4 x i32]* %arrayidx51, i64 0, i64 %idxprom52, !dbg !116
  store i32 %add, i32* %arrayidx53, align 4, !dbg !119
  br label %for.inc54, !dbg !120

for.inc54:                                        ; preds = %for.body35
  %29 = load i32, i32* %k32, align 4, !dbg !121
  %inc55 = add nsw i32 %29, 1, !dbg !121
  store i32 %inc55, i32* %k32, align 4, !dbg !121
  br label %for.cond33, !dbg !122, !llvm.loop !123

for.end56:                                        ; preds = %for.cond33
  br label %for.inc57, !dbg !125

for.inc57:                                        ; preds = %for.end56
  %30 = load i32, i32* %j28, align 4, !dbg !126
  %inc58 = add nsw i32 %30, 1, !dbg !126
  store i32 %inc58, i32* %j28, align 4, !dbg !126
  br label %for.cond29, !dbg !127, !llvm.loop !128

for.end59:                                        ; preds = %for.cond29
  br label %for.inc60, !dbg !130

for.inc60:                                        ; preds = %for.end59
  %31 = load i32, i32* %i24, align 4, !dbg !131
  %inc61 = add nsw i32 %31, 1, !dbg !131
  store i32 %inc61, i32* %i24, align 4, !dbg !131
  br label %for.cond25, !dbg !132, !llvm.loop !133

for.end62:                                        ; preds = %for.cond25
  call void @llvm.dbg.declare(metadata i32* %i63, metadata !135, metadata !DIExpression()), !dbg !137
  store i32 0, i32* %i63, align 4, !dbg !137
  br label %for.cond64, !dbg !138

for.cond64:                                       ; preds = %for.inc125, %for.end62
  %32 = load i32, i32* %i63, align 4, !dbg !139
  %cmp65 = icmp slt i32 %32, 2, !dbg !141
  br i1 %cmp65, label %for.body66, label %for.end127, !dbg !142

for.body66:                                       ; preds = %for.cond64
  call void @llvm.dbg.declare(metadata i32* %j67, metadata !143, metadata !DIExpression()), !dbg !146
  store i32 0, i32* %j67, align 4, !dbg !146
  br label %for.cond68, !dbg !147

for.cond68:                                       ; preds = %for.inc122, %for.body66
  %33 = load i32, i32* %j67, align 4, !dbg !148
  %cmp69 = icmp slt i32 %33, 3, !dbg !150
  br i1 %cmp69, label %for.body70, label %for.end124, !dbg !151

for.body70:                                       ; preds = %for.cond68
  call void @llvm.dbg.declare(metadata i32* %k71, metadata !152, metadata !DIExpression()), !dbg !155
  store i32 0, i32* %k71, align 4, !dbg !155
  br label %for.cond72, !dbg !156

for.cond72:                                       ; preds = %for.inc119, %for.body70
  %34 = load i32, i32* %k71, align 4, !dbg !157
  %cmp73 = icmp slt i32 %34, 4, !dbg !159
  br i1 %cmp73, label %for.body74, label %for.end121, !dbg !160

for.body74:                                       ; preds = %for.cond72
  %35 = load i32, i32* %i63, align 4, !dbg !161
  %idxprom75 = sext i32 %35 to i64, !dbg !163
  %arrayidx76 = getelementptr inbounds [2 x [3 x [4 x i32]]], [2 x [3 x [4 x i32]]]* %arr1, i64 0, i64 %idxprom75, !dbg !163
  %36 = load i32, i32* %j67, align 4, !dbg !164
  %idxprom77 = sext i32 %36 to i64, !dbg !163
  %arrayidx78 = getelementptr inbounds [3 x [4 x i32]], [3 x [4 x i32]]* %arrayidx76, i64 0, i64 %idxprom77, !dbg !163
  %37 = load i32, i32* %k71, align 4, !dbg !165
  %idxprom79 = sext i32 %37 to i64, !dbg !163
  %arrayidx80 = getelementptr inbounds [4 x i32], [4 x i32]* %arrayidx78, i64 0, i64 %idxprom79, !dbg !163
  %38 = load i32, i32* %arrayidx80, align 4, !dbg !163
  %39 = load i32, i32* %i63, align 4, !dbg !166
  %idxprom81 = sext i32 %39 to i64, !dbg !167
  %arrayidx82 = getelementptr inbounds [2 x [3 x [4 x i32]]], [2 x [3 x [4 x i32]]]* %arr2, i64 0, i64 %idxprom81, !dbg !167
  %40 = load i32, i32* %j67, align 4, !dbg !168
  %idxprom83 = sext i32 %40 to i64, !dbg !167
  %arrayidx84 = getelementptr inbounds [3 x [4 x i32]], [3 x [4 x i32]]* %arrayidx82, i64 0, i64 %idxprom83, !dbg !167
  %41 = load i32, i32* %k71, align 4, !dbg !169
  %idxprom85 = sext i32 %41 to i64, !dbg !167
  %arrayidx86 = getelementptr inbounds [4 x i32], [4 x i32]* %arrayidx84, i64 0, i64 %idxprom85, !dbg !167
  %42 = load i32, i32* %arrayidx86, align 4, !dbg !167
  %cmp87 = icmp eq i32 %38, %42, !dbg !170
  %conv = zext i1 %cmp87 to i32, !dbg !170
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !171
  %43 = load i32, i32* %i63, align 4, !dbg !172
  %idxprom88 = sext i32 %43 to i64, !dbg !173
  %arrayidx89 = getelementptr inbounds [2 x [3 x [4 x i32]]], [2 x [3 x [4 x i32]]]* %arr3, i64 0, i64 %idxprom88, !dbg !173
  %44 = load i32, i32* %j67, align 4, !dbg !174
  %idxprom90 = sext i32 %44 to i64, !dbg !173
  %arrayidx91 = getelementptr inbounds [3 x [4 x i32]], [3 x [4 x i32]]* %arrayidx89, i64 0, i64 %idxprom90, !dbg !173
  %45 = load i32, i32* %k71, align 4, !dbg !175
  %idxprom92 = sext i32 %45 to i64, !dbg !173
  %arrayidx93 = getelementptr inbounds [4 x i32], [4 x i32]* %arrayidx91, i64 0, i64 %idxprom92, !dbg !173
  %46 = load i32, i32* %arrayidx93, align 4, !dbg !173
  %47 = load i32, i32* %i63, align 4, !dbg !176
  %idxprom94 = sext i32 %47 to i64, !dbg !177
  %arrayidx95 = getelementptr inbounds [2 x [3 x [4 x i32]]], [2 x [3 x [4 x i32]]]* %arr1, i64 0, i64 %idxprom94, !dbg !177
  %48 = load i32, i32* %j67, align 4, !dbg !178
  %idxprom96 = sext i32 %48 to i64, !dbg !177
  %arrayidx97 = getelementptr inbounds [3 x [4 x i32]], [3 x [4 x i32]]* %arrayidx95, i64 0, i64 %idxprom96, !dbg !177
  %49 = load i32, i32* %k71, align 4, !dbg !179
  %idxprom98 = sext i32 %49 to i64, !dbg !177
  %arrayidx99 = getelementptr inbounds [4 x i32], [4 x i32]* %arrayidx97, i64 0, i64 %idxprom98, !dbg !177
  %50 = load i32, i32* %arrayidx99, align 4, !dbg !177
  %mul = mul nsw i32 2, %50, !dbg !180
  %cmp100 = icmp eq i32 %46, %mul, !dbg !181
  %conv101 = zext i1 %cmp100 to i32, !dbg !181
  %call102 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv101), !dbg !182
  %51 = load i32, i32* %i63, align 4, !dbg !183
  %idxprom103 = sext i32 %51 to i64, !dbg !184
  %arrayidx104 = getelementptr inbounds [2 x [3 x [4 x i32]]], [2 x [3 x [4 x i32]]]* %arr3, i64 0, i64 %idxprom103, !dbg !184
  %52 = load i32, i32* %j67, align 4, !dbg !185
  %idxprom105 = sext i32 %52 to i64, !dbg !184
  %arrayidx106 = getelementptr inbounds [3 x [4 x i32]], [3 x [4 x i32]]* %arrayidx104, i64 0, i64 %idxprom105, !dbg !184
  %53 = load i32, i32* %k71, align 4, !dbg !186
  %idxprom107 = sext i32 %53 to i64, !dbg !184
  %arrayidx108 = getelementptr inbounds [4 x i32], [4 x i32]* %arrayidx106, i64 0, i64 %idxprom107, !dbg !184
  %54 = load i32, i32* %arrayidx108, align 4, !dbg !184
  %55 = load i32, i32* %i63, align 4, !dbg !187
  %idxprom109 = sext i32 %55 to i64, !dbg !188
  %arrayidx110 = getelementptr inbounds [2 x [3 x [4 x i32]]], [2 x [3 x [4 x i32]]]* %arr2, i64 0, i64 %idxprom109, !dbg !188
  %56 = load i32, i32* %j67, align 4, !dbg !189
  %idxprom111 = sext i32 %56 to i64, !dbg !188
  %arrayidx112 = getelementptr inbounds [3 x [4 x i32]], [3 x [4 x i32]]* %arrayidx110, i64 0, i64 %idxprom111, !dbg !188
  %57 = load i32, i32* %k71, align 4, !dbg !190
  %idxprom113 = sext i32 %57 to i64, !dbg !188
  %arrayidx114 = getelementptr inbounds [4 x i32], [4 x i32]* %arrayidx112, i64 0, i64 %idxprom113, !dbg !188
  %58 = load i32, i32* %arrayidx114, align 4, !dbg !188
  %mul115 = mul nsw i32 2, %58, !dbg !191
  %cmp116 = icmp eq i32 %54, %mul115, !dbg !192
  %conv117 = zext i1 %cmp116 to i32, !dbg !192
  %call118 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv117), !dbg !193
  br label %for.inc119, !dbg !194

for.inc119:                                       ; preds = %for.body74
  %59 = load i32, i32* %k71, align 4, !dbg !195
  %inc120 = add nsw i32 %59, 1, !dbg !195
  store i32 %inc120, i32* %k71, align 4, !dbg !195
  br label %for.cond72, !dbg !196, !llvm.loop !197

for.end121:                                       ; preds = %for.cond72
  br label %for.inc122, !dbg !199

for.inc122:                                       ; preds = %for.end121
  %60 = load i32, i32* %j67, align 4, !dbg !200
  %inc123 = add nsw i32 %60, 1, !dbg !200
  store i32 %inc123, i32* %j67, align 4, !dbg !200
  br label %for.cond68, !dbg !201, !llvm.loop !202

for.end124:                                       ; preds = %for.cond68
  br label %for.inc125, !dbg !204

for.inc125:                                       ; preds = %for.end124
  %61 = load i32, i32* %i63, align 4, !dbg !205
  %inc126 = add nsw i32 %61, 1, !dbg !205
  store i32 %inc126, i32* %i63, align 4, !dbg !205
  br label %for.cond64, !dbg !206, !llvm.loop !207

for.end127:                                       ; preds = %for.cond64
  ret i32 0, !dbg !209
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 8.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression/3d_array1")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.0 "}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 4, type: !8, scopeLine: 5, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "arr1", scope: !7, file: !1, line: 6, type: !12)
!12 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 768, elements: !13)
!13 = !{!14, !15, !16}
!14 = !DISubrange(count: 2)
!15 = !DISubrange(count: 3)
!16 = !DISubrange(count: 4)
!17 = !DILocation(line: 6, column: 6, scope: !7)
!18 = !DILocalVariable(name: "arr2", scope: !7, file: !1, line: 7, type: !12)
!19 = !DILocation(line: 7, column: 6, scope: !7)
!20 = !DILocalVariable(name: "x", scope: !7, file: !1, line: 9, type: !10)
!21 = !DILocation(line: 9, column: 6, scope: !7)
!22 = !DILocalVariable(name: "i", scope: !23, file: !1, line: 10, type: !10)
!23 = distinct !DILexicalBlock(scope: !7, file: !1, line: 10, column: 2)
!24 = !DILocation(line: 10, column: 10, scope: !23)
!25 = !DILocation(line: 10, column: 6, scope: !23)
!26 = !DILocation(line: 10, column: 16, scope: !27)
!27 = distinct !DILexicalBlock(scope: !23, file: !1, line: 10, column: 2)
!28 = !DILocation(line: 10, column: 17, scope: !27)
!29 = !DILocation(line: 10, column: 2, scope: !23)
!30 = !DILocalVariable(name: "j", scope: !31, file: !1, line: 12, type: !10)
!31 = distinct !DILexicalBlock(scope: !32, file: !1, line: 12, column: 3)
!32 = distinct !DILexicalBlock(scope: !27, file: !1, line: 11, column: 2)
!33 = !DILocation(line: 12, column: 11, scope: !31)
!34 = !DILocation(line: 12, column: 7, scope: !31)
!35 = !DILocation(line: 12, column: 17, scope: !36)
!36 = distinct !DILexicalBlock(scope: !31, file: !1, line: 12, column: 3)
!37 = !DILocation(line: 12, column: 18, scope: !36)
!38 = !DILocation(line: 12, column: 3, scope: !31)
!39 = !DILocalVariable(name: "k", scope: !40, file: !1, line: 14, type: !10)
!40 = distinct !DILexicalBlock(scope: !41, file: !1, line: 14, column: 7)
!41 = distinct !DILexicalBlock(scope: !36, file: !1, line: 13, column: 3)
!42 = !DILocation(line: 14, column: 15, scope: !40)
!43 = !DILocation(line: 14, column: 11, scope: !40)
!44 = !DILocation(line: 14, column: 22, scope: !45)
!45 = distinct !DILexicalBlock(scope: !40, file: !1, line: 14, column: 7)
!46 = !DILocation(line: 14, column: 24, scope: !45)
!47 = !DILocation(line: 14, column: 7, scope: !40)
!48 = !DILocation(line: 16, column: 22, scope: !49)
!49 = distinct !DILexicalBlock(scope: !45, file: !1, line: 15, column: 7)
!50 = !DILocation(line: 16, column: 13, scope: !49)
!51 = !DILocation(line: 16, column: 8, scope: !49)
!52 = !DILocation(line: 16, column: 16, scope: !49)
!53 = !DILocation(line: 16, column: 19, scope: !49)
!54 = !DILocation(line: 16, column: 21, scope: !49)
!55 = !DILocation(line: 17, column: 22, scope: !49)
!56 = !DILocation(line: 17, column: 13, scope: !49)
!57 = !DILocation(line: 17, column: 8, scope: !49)
!58 = !DILocation(line: 17, column: 16, scope: !49)
!59 = !DILocation(line: 17, column: 19, scope: !49)
!60 = !DILocation(line: 17, column: 21, scope: !49)
!61 = !DILocation(line: 18, column: 9, scope: !49)
!62 = !DILocation(line: 19, column: 7, scope: !49)
!63 = !DILocation(line: 14, column: 31, scope: !45)
!64 = !DILocation(line: 14, column: 7, scope: !45)
!65 = distinct !{!65, !47, !66}
!66 = !DILocation(line: 19, column: 7, scope: !40)
!67 = !DILocation(line: 20, column: 3, scope: !41)
!68 = !DILocation(line: 12, column: 25, scope: !36)
!69 = !DILocation(line: 12, column: 3, scope: !36)
!70 = distinct !{!70, !38, !71}
!71 = !DILocation(line: 20, column: 3, scope: !31)
!72 = !DILocation(line: 21, column: 2, scope: !32)
!73 = !DILocation(line: 10, column: 24, scope: !27)
!74 = !DILocation(line: 10, column: 2, scope: !27)
!75 = distinct !{!75, !29, !76}
!76 = !DILocation(line: 21, column: 2, scope: !23)
!77 = !DILocalVariable(name: "arr3", scope: !7, file: !1, line: 23, type: !12)
!78 = !DILocation(line: 23, column: 6, scope: !7)
!79 = !DILocalVariable(name: "i", scope: !80, file: !1, line: 27, type: !10)
!80 = distinct !DILexicalBlock(scope: !7, file: !1, line: 27, column: 2)
!81 = !DILocation(line: 27, column: 10, scope: !80)
!82 = !DILocation(line: 27, column: 6, scope: !80)
!83 = !DILocation(line: 27, column: 16, scope: !84)
!84 = distinct !DILexicalBlock(scope: !80, file: !1, line: 27, column: 2)
!85 = !DILocation(line: 27, column: 17, scope: !84)
!86 = !DILocation(line: 27, column: 2, scope: !80)
!87 = !DILocalVariable(name: "j", scope: !88, file: !1, line: 29, type: !10)
!88 = distinct !DILexicalBlock(scope: !89, file: !1, line: 29, column: 3)
!89 = distinct !DILexicalBlock(scope: !84, file: !1, line: 28, column: 2)
!90 = !DILocation(line: 29, column: 11, scope: !88)
!91 = !DILocation(line: 29, column: 7, scope: !88)
!92 = !DILocation(line: 29, column: 17, scope: !93)
!93 = distinct !DILexicalBlock(scope: !88, file: !1, line: 29, column: 3)
!94 = !DILocation(line: 29, column: 18, scope: !93)
!95 = !DILocation(line: 29, column: 3, scope: !88)
!96 = !DILocalVariable(name: "k", scope: !97, file: !1, line: 31, type: !10)
!97 = distinct !DILexicalBlock(scope: !98, file: !1, line: 31, column: 7)
!98 = distinct !DILexicalBlock(scope: !93, file: !1, line: 30, column: 3)
!99 = !DILocation(line: 31, column: 15, scope: !97)
!100 = !DILocation(line: 31, column: 11, scope: !97)
!101 = !DILocation(line: 31, column: 22, scope: !102)
!102 = distinct !DILexicalBlock(scope: !97, file: !1, line: 31, column: 7)
!103 = !DILocation(line: 31, column: 24, scope: !102)
!104 = !DILocation(line: 31, column: 7, scope: !97)
!105 = !DILocation(line: 33, column: 29, scope: !106)
!106 = distinct !DILexicalBlock(scope: !102, file: !1, line: 32, column: 7)
!107 = !DILocation(line: 33, column: 24, scope: !106)
!108 = !DILocation(line: 33, column: 32, scope: !106)
!109 = !DILocation(line: 33, column: 35, scope: !106)
!110 = !DILocation(line: 33, column: 45, scope: !106)
!111 = !DILocation(line: 33, column: 40, scope: !106)
!112 = !DILocation(line: 33, column: 48, scope: !106)
!113 = !DILocation(line: 33, column: 51, scope: !106)
!114 = !DILocation(line: 33, column: 38, scope: !106)
!115 = !DILocation(line: 33, column: 13, scope: !106)
!116 = !DILocation(line: 33, column: 8, scope: !106)
!117 = !DILocation(line: 33, column: 16, scope: !106)
!118 = !DILocation(line: 33, column: 19, scope: !106)
!119 = !DILocation(line: 33, column: 22, scope: !106)
!120 = !DILocation(line: 34, column: 7, scope: !106)
!121 = !DILocation(line: 31, column: 31, scope: !102)
!122 = !DILocation(line: 31, column: 7, scope: !102)
!123 = distinct !{!123, !104, !124}
!124 = !DILocation(line: 34, column: 7, scope: !97)
!125 = !DILocation(line: 35, column: 3, scope: !98)
!126 = !DILocation(line: 29, column: 25, scope: !93)
!127 = !DILocation(line: 29, column: 3, scope: !93)
!128 = distinct !{!128, !95, !129}
!129 = !DILocation(line: 35, column: 3, scope: !88)
!130 = !DILocation(line: 36, column: 2, scope: !89)
!131 = !DILocation(line: 27, column: 24, scope: !84)
!132 = !DILocation(line: 27, column: 2, scope: !84)
!133 = distinct !{!133, !86, !134}
!134 = !DILocation(line: 36, column: 2, scope: !80)
!135 = !DILocalVariable(name: "i", scope: !136, file: !1, line: 39, type: !10)
!136 = distinct !DILexicalBlock(scope: !7, file: !1, line: 39, column: 2)
!137 = !DILocation(line: 39, column: 10, scope: !136)
!138 = !DILocation(line: 39, column: 6, scope: !136)
!139 = !DILocation(line: 39, column: 15, scope: !140)
!140 = distinct !DILexicalBlock(scope: !136, file: !1, line: 39, column: 2)
!141 = !DILocation(line: 39, column: 16, scope: !140)
!142 = !DILocation(line: 39, column: 2, scope: !136)
!143 = !DILocalVariable(name: "j", scope: !144, file: !1, line: 41, type: !10)
!144 = distinct !DILexicalBlock(scope: !145, file: !1, line: 41, column: 3)
!145 = distinct !DILexicalBlock(scope: !140, file: !1, line: 40, column: 2)
!146 = !DILocation(line: 41, column: 11, scope: !144)
!147 = !DILocation(line: 41, column: 7, scope: !144)
!148 = !DILocation(line: 41, column: 17, scope: !149)
!149 = distinct !DILexicalBlock(scope: !144, file: !1, line: 41, column: 3)
!150 = !DILocation(line: 41, column: 18, scope: !149)
!151 = !DILocation(line: 41, column: 3, scope: !144)
!152 = !DILocalVariable(name: "k", scope: !153, file: !1, line: 43, type: !10)
!153 = distinct !DILexicalBlock(scope: !154, file: !1, line: 43, column: 7)
!154 = distinct !DILexicalBlock(scope: !149, file: !1, line: 42, column: 3)
!155 = !DILocation(line: 43, column: 15, scope: !153)
!156 = !DILocation(line: 43, column: 11, scope: !153)
!157 = !DILocation(line: 43, column: 22, scope: !158)
!158 = distinct !DILexicalBlock(scope: !153, file: !1, line: 43, column: 7)
!159 = !DILocation(line: 43, column: 24, scope: !158)
!160 = !DILocation(line: 43, column: 7, scope: !153)
!161 = !DILocation(line: 45, column: 23, scope: !162)
!162 = distinct !DILexicalBlock(scope: !158, file: !1, line: 44, column: 7)
!163 = !DILocation(line: 45, column: 18, scope: !162)
!164 = !DILocation(line: 45, column: 26, scope: !162)
!165 = !DILocation(line: 45, column: 29, scope: !162)
!166 = !DILocation(line: 45, column: 40, scope: !162)
!167 = !DILocation(line: 45, column: 35, scope: !162)
!168 = !DILocation(line: 45, column: 43, scope: !162)
!169 = !DILocation(line: 45, column: 46, scope: !162)
!170 = !DILocation(line: 45, column: 32, scope: !162)
!171 = !DILocation(line: 45, column: 11, scope: !162)
!172 = !DILocation(line: 46, column: 20, scope: !162)
!173 = !DILocation(line: 46, column: 15, scope: !162)
!174 = !DILocation(line: 46, column: 23, scope: !162)
!175 = !DILocation(line: 46, column: 26, scope: !162)
!176 = !DILocation(line: 46, column: 39, scope: !162)
!177 = !DILocation(line: 46, column: 34, scope: !162)
!178 = !DILocation(line: 46, column: 42, scope: !162)
!179 = !DILocation(line: 46, column: 45, scope: !162)
!180 = !DILocation(line: 46, column: 33, scope: !162)
!181 = !DILocation(line: 46, column: 29, scope: !162)
!182 = !DILocation(line: 46, column: 8, scope: !162)
!183 = !DILocation(line: 47, column: 20, scope: !162)
!184 = !DILocation(line: 47, column: 15, scope: !162)
!185 = !DILocation(line: 47, column: 23, scope: !162)
!186 = !DILocation(line: 47, column: 26, scope: !162)
!187 = !DILocation(line: 47, column: 39, scope: !162)
!188 = !DILocation(line: 47, column: 34, scope: !162)
!189 = !DILocation(line: 47, column: 42, scope: !162)
!190 = !DILocation(line: 47, column: 45, scope: !162)
!191 = !DILocation(line: 47, column: 33, scope: !162)
!192 = !DILocation(line: 47, column: 29, scope: !162)
!193 = !DILocation(line: 47, column: 8, scope: !162)
!194 = !DILocation(line: 48, column: 7, scope: !162)
!195 = !DILocation(line: 43, column: 31, scope: !158)
!196 = !DILocation(line: 43, column: 7, scope: !158)
!197 = distinct !{!197, !160, !198}
!198 = !DILocation(line: 48, column: 7, scope: !153)
!199 = !DILocation(line: 49, column: 3, scope: !154)
!200 = !DILocation(line: 41, column: 25, scope: !149)
!201 = !DILocation(line: 41, column: 3, scope: !149)
!202 = distinct !{!202, !151, !203}
!203 = !DILocation(line: 49, column: 3, scope: !144)
!204 = !DILocation(line: 50, column: 2, scope: !145)
!205 = !DILocation(line: 39, column: 22, scope: !140)
!206 = !DILocation(line: 39, column: 2, scope: !140)
!207 = distinct !{!207, !142, !208}
!208 = !DILocation(line: 50, column: 2, scope: !136)
!209 = !DILocation(line: 54, column: 2, scope: !7)
