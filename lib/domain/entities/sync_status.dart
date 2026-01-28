enum SyncStatus { pending, syncing, synced, failed, updated }

SyncStatus syncStatusFromInt(int value) {
  if (value >= 0 && value < SyncStatus.values.length) {
    return SyncStatus.values[value];
  } else {
    return SyncStatus.pending;
  }
}
